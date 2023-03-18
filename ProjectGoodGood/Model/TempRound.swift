//
//  TempRound.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 3/15/23.
//

import FirebaseFirestoreSwift
import Firebase

struct TempRound: Identifiable, Decodable {
    var id = UUID().uuidString
    let userId: String
    var totalScore: Int
    var scores: [String : Int]
    var putts: [String: Int]
    
    var user: User?
}
