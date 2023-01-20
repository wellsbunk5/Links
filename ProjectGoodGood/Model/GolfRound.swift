//
//  GolfRound.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/20/23.
//

import FirebaseFirestoreSwift
import Firebase

struct GolfRound: Identifiable, Decodable {
    @DocumentID var id: String?
    let score: Int
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    
    var user: User?
    
}
