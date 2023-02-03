//
//  GolfRoundService.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/20/23.
//

import Firebase

struct GolfRoundService {
    
    func postRound(_ round: GolfRound) {
//        @DocumentID var id: String?
//        let userId: String
//        let courseId: String
//        var timestamp: Timestamp
//        var likes: Int
//        let numHoles: Int
//        var totalScore: Int
//        var scores: [String : Int]
//        var putts: [String: Int]
//        var roundPictureUrls: [String]
        
        let data = ["userId": round.userId,
                    "courseId": round.courseId,
                    "timestamp": Timestamp(date: Date()),
                    "likes": 0,
                    "numHoles": round.numHoles,
                    "totalScore": round.totalScore,
                    "scores": round.scores,
                    "putts": round.putts,
                    "roundPictureUrls": round.roundPictureUrls] as [String : Any]
        
        let newDocRef = Firestore.firestore().collection("rounds").document()
            
        newDocRef.setData(data) { _ in
            Firestore.firestore().collection("user-rounds").document(round.userId).collection("rounds").document(newDocRef.documentID)
                .setData([:])
        }
    }
    
    func fetchRounds(completion: @escaping([GolfRound]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var rounds = [GolfRound]()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("following")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let userId = doc.documentID
                    
                    Firestore.firestore().collection("user-rounds").document(userId).collection("rounds")
                        .getDocuments { snapshot, _ in
                            guard let documents = snapshot?.documents else { return }
                            
                            documents.forEach { doc in
                                let roundId = doc.documentID
                                
                                Firestore.firestore().collection("rounds").document(roundId)
                                    .getDocument { snapshot, _ in
                                        guard let round = try? snapshot?.data(as: GolfRound.self) else { return }
                                        rounds.append(round)
                                        
                                        completion(rounds)
                                    }
                        }
                        
                    }
                }
            
        }
    }
    
    func fetchRounds(forUid uid: String, completion: @escaping([GolfRound]) -> Void) {
        Firestore.firestore().collection("rounds")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let rounds = documents.compactMap({ try? $0.data(as: GolfRound.self) })
                completion(rounds.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
        }
    }
    
    func likeRound(_ round: GolfRound, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let roundId = round.id else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("rounds").document(roundId)
            .updateData(["likes": round.likes + 1]) { _ in
                userLikesRef.document(roundId).setData([:]) { _ in
                    completion()
                }
            }
    }
    
    func unlikeRound(_ round: GolfRound, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let roundId = round.id else {return}
        guard round.likes > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("rounds").document(roundId)
            .updateData(["likes": round.likes - 1]) { _ in
                userLikesRef.document(roundId).delete { _ in
                    completion()
                }
            }
    }
    
    func checkIfUserLikedRound(_ round: GolfRound, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let roundId = round.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(roundId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
}
