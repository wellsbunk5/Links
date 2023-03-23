//
//  User.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/19/23.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable, Equatable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
    let profileImageUrl: String
    var numFollowers: Int
    var numFollowing: Int
    var age: Int
    var gender: String
    var frequency: String
    
    var greensInRegulation: Int
    var totalPutts: Int
    var totalHolesPlayed: Int
    var roundsPlayed: Int
    var handicap: Int
    var totalEagle: Int
    var totalBirdie: Int
    var totalPar: Int
    var totalBogey: Int
    var totalDouble: Int
    var totalTriple: Int

    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id}
    var doesFollow: Bool? = false
}

struct UserQuestions {
    var age: Int
    var gender: String
    var frequency: String
    var handicap: Int
}
