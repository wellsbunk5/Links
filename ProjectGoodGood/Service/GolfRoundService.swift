//
//  GolfRoundService.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/20/23.
//

import Firebase

struct GolfRoundService {
    
    func postRound(_ round: GolfRound) {

        
        let data = ["userId": round.userId,
                    "courseId": round.courseId,
                    "timestamp": Timestamp(date: Date()),
                    "likes": 0,
                    "numHoles": round.numHoles,
                    "totalScore": round.totalScore,
                    "scores": round.scores,
                    "putts": round.putts,
                    "greensInRegulation": round.greensInRegulation,
                    "totalPutts": round.totalPutts,
                    "totalEagle": round.totalEagle,
                    "totalBirdie": round.totalBirdie,
                    "totalPar": round.totalPar,
                    "totalBogey": round.totalBogey,
                    "totalDouble": round.totalDouble,
                    "totalTriple": round.totalTriple,
                    "roundPictureUrls": round.roundPictureUrls] as [String : Any]
        
        let newDocRef = Firestore.firestore().collection("rounds").document()
            
        newDocRef.setData(data) { _ in
            Firestore.firestore().collection("user-rounds").document(round.userId).collection("rounds").document(newDocRef.documentID)
                .setData([:])
        }
    }
     
    func updateTempGroup(_ tempGroup: TempGroup) {
        if let docId = tempGroup.id {
            var tempRounds = [[String:Any]]()
            for round in tempGroup.tempRounds {
                let tempRoundData = [
                    "id" : round.id,
                    "userId": round.userId,
                    "totalScore": round.totalScore,
                    "scores": round.scores,
                    "putts": round.putts] as [String: Any]

                tempRounds.append(tempRoundData)
            }
            
            let data = [
                "currentHole": tempGroup.currentHole,
                "tempRounds" : tempRounds] as [String: Any]
            
            Firestore.firestore().collection("temp-groups").document(docId).updateData(data)
        }

        
    }
    
    func postTempGroup(_ tempGroup: TempGroup, completion: @escaping(String)-> Void) {
        
        var tempRounds = [[String:Any]]()
        var players = [[String: Any]]()
        for round in tempGroup.tempRounds {
            let tempRoundData = [
                "id" : round.id,
                "userId": round.userId,
                "totalScore": round.totalScore,
                "scores": round.scores,
                "putts": round.putts] as [String: Any]

            tempRounds.append(tempRoundData)
        }
        
        let courseData = [
            "fullName": tempGroup.course.fullName,
            "nickname": tempGroup.course.nickname,
            "address": tempGroup.course.address,
            "city": tempGroup.course.city,
            "state": tempGroup.course.state,
            "zip": tempGroup.course.zip,
            "totalPar": tempGroup.course.totalPar,
            "pars": tempGroup.course.pars] as [String: Any]
        
        for player in tempGroup.players {
            let playerData = [
                "username": player.username,
                "fullname": player.fullname,
                "email": player.email,
                "profileImageUrl": player.profileImageUrl,
                "numFollowers": player.numFollowers,
                "numFollowing": player.numFollowing,
                
                "greensInRegulation": player.greensInRegulation,
                "totalPutts": player.totalPutts,
                "totalHolesPlayed": player.totalHolesPlayed,
                "roundsPlayed": player.roundsPlayed,
                "handicap": player.handicap,
                "totalEagle": player.totalEagle,
                "totalBirdie": player.totalBirdie,
                "totalPar": player.totalPar,
                "totalBogey": player.totalBogey,
                "totalDouble": player.totalDouble,
                "totalTriple": player.totalTriple] as [String: Any]
            
            players.append(playerData)
        }
        
        let groupData = [
            "courseId": tempGroup.courseId,
            "timestamp": tempGroup.timestamp,
            "startingHole": tempGroup.startingHole,
            "endingHole": tempGroup.endingHole,
            "currentHole": tempGroup.currentHole,
            "numHoles": tempGroup.numHoles,
            "groupJoinCode": tempGroup.groupJoinCode,
            "tempRounds" : tempRounds,
            "players": players,
            "course": courseData,
            "roundPictureUrls": tempGroup.roundPictureUrls] as [String: Any]
        
        let newDocRef = Firestore.firestore().collection("temp-groups").document()
        
        newDocRef.setData(groupData)
        completion(newDocRef.documentID)
    }
    
    func followTempGroup(_ tempGroupId: String, completion: @escaping(TempGroup) -> Void){
        Firestore.firestore().collection("temp-groups").document(tempGroupId)
            .addSnapshotListener { listenerSnapshot, _ in
                guard let document = listenerSnapshot else { return }
                guard let tempGroup = try? document.data(as: TempGroup.self) else {return}
                
                completion(tempGroup)
            }
                        
    }
    
    func getTempGroup(by joinCode: String,completion: @escaping(TempGroup) -> Void) {
        let tempGroupRef = Firestore.firestore().collection("temp-groups")
            
        tempGroupRef.whereField("groupJoinCode", isEqualTo: joinCode)
            .getDocuments() { (snapshot, _) in
                        guard let documents = snapshot?.documents else {return}
                        
                        if let document =  documents.first {
                            guard let tempGroup = try? document.data(as: TempGroup.self) else {return}
                            completion(tempGroup)
                        }
            }
    }
    
    func fetchRounds(completion: @escaping([GolfRound]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var followedUsers = [uid]
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("following")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    followedUsers.append(doc.documentID)
                    //                    let userId = doc.documentID
                    //
                    //                    Firestore.firestore().collection("user-rounds").document(userId).collection("rounds")
                    //                        .getDocuments { snapshot, _ in
                    //                            guard let documents = snapshot?.documents else { return }
                    //
                    //                            documents.forEach { doc in
                    //                                let roundId = doc.documentID
                    //
                    //                                Firestore.firestore().collection("rounds").document(roundId)
                    //                                    .getDocument { snapshot, _ in
                    //                                        guard let round = try? snapshot?.data(as: GolfRound.self) else { return }
                    //                                        rounds.append(round)
                    //
                    //                                        completion(rounds)
                    //                                    }
                    //                        }
                    //
                    //                    }
                }
                Firestore.firestore().collection("rounds")
                      .whereField("userId", in: followedUsers)
                      .order(by: "timestamp", descending: true).limit(to: 15)
                      .addSnapshotListener { querySnapshot, _ in
                             guard let documents = querySnapshot?.documents else { return }
                          
                          let rounds = documents.compactMap({ try? $0.data(as: GolfRound.self) })
                          completion(rounds)
                    }
            }
        
//        listener.remove()
    }
    
    func fetchRounds(forUid uid: String, completion: @escaping([GolfRound]) -> Void) {
        Firestore.firestore().collection("rounds")
            .whereField("userId", isEqualTo: uid)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let rounds = documents.compactMap({ try? $0.data(as: GolfRound.self) })
                completion(rounds)
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
