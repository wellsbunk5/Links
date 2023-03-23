//
//  UserService.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/19/23.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchActiveUser ( completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
    
    func fetchFriends(completion: @escaping([User]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var friends = [User]()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("following")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let userId = doc.documentID
                    
                    Firestore.firestore().collection("users").document(userId)
                        .getDocument { snapshot, _ in
                            guard let snapshot = snapshot else { return }
                            
                            guard let user = try? snapshot.data(as: User.self) else { return }
                            
                            friends.append(user)
                            completion(friends)
                        }
                }
            }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self) })
                completion(users)
            }
    }
    
    func followUser(_ userToFollow: User, with activeUser: User, completion: @escaping() -> Void) {
        guard let activeUserId = activeUser.id else { return }
        guard let usersId = userToFollow.id else {return}
        
        let activeUserRef = Firestore.firestore().collection("users").document(activeUserId)
        let otherUserRef = Firestore.firestore().collection("users").document(usersId)
        
        activeUserRef
            .updateData(["numFollowing": activeUser.numFollowing + 1]) { _ in
                activeUserRef.collection("following").document(usersId).setData([:]) { _ in
                    otherUserRef.updateData(["numFollowers": userToFollow.numFollowers + 1]) { _ in
                        otherUserRef.collection("followers").document(activeUserId).setData([:]) { _ in
                            completion()
                        }
                    }
                }
            }
    }
    
    func unfollowUser(_ userToUnfollow: User, with activeUser: User, completion: @escaping() -> Void) {
        guard let activeUserId = activeUser.id else { return }
        guard let usersId = userToUnfollow.id else {return}
        guard userToUnfollow.numFollowers > 0 else { return }
        guard activeUser.numFollowing > 0 else { return }
        
        let activeUserRef = Firestore.firestore().collection("users").document(activeUserId)
        let otherUserRef = Firestore.firestore().collection("users").document(usersId)
        
        activeUserRef
            .updateData(["numFollowing": activeUser.numFollowing - 1]) { _ in
                activeUserRef.collection("following").document(usersId).delete { _ in
                    otherUserRef.updateData(["numFollowers": userToUnfollow.numFollowers - 1]) { _ in
                        otherUserRef.collection("followers").document(activeUserId).delete { _ in
                            completion()
                        }
                    }
                }
            }
    }
    
    func checkIfActiveUserFollows(_ userToCheck: User, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let otherUserId = userToCheck.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("following")
            .document(otherUserId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func updateUserStats(with round: GolfRound) {
        if let user = round.user {
            Firestore.firestore().collection("users").document(round.userId)
                .updateData(
                    ["greensInRegulation": user.greensInRegulation + round.greensInRegulation,
                     "totalPutts": user.totalPutts + round.totalPutts,
                     "totalHolesPlayed": user.totalHolesPlayed + round.numHoles,
                     "roundsPlayed": user.roundsPlayed + 1,
                     "totalEagle": user.totalEagle + round.totalEagle,
                     "totalBirdie": user.totalBirdie + round.totalBirdie,
                     "totalPar": user.totalPar + round.totalPar,
                     "totalBogey": user.totalBogey + round.totalBogey,
                     "totalDouble": user.totalDouble + round.totalDouble,
                     "totalTriple": user.totalTriple + round.totalTriple]
                )
        }

    }
    func updateUserQuestions(_ userQuestions: UserQuestions) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users")
            .document(uid).updateData(["age": userQuestions.age,
                                       "gender": userQuestions.gender,
                                       "frequency": userQuestions.frequency,
                                       "handicap": userQuestions.handicap,
                                      ])
    }
}
