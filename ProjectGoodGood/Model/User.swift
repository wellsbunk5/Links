//
//  User.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/19/23.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
    let profileImageUrl: String
    let numFollowers: Int
    let numFollowing: Int
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id}
    var doesFollow: Bool? = false
}
