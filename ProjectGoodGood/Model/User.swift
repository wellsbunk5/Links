//
//  User.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/19/23.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
    let profileImageUrl: String
}
