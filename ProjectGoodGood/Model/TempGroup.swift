//
//  File.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 3/15/23.
//

import FirebaseFirestoreSwift
import Firebase

struct TempGroup: Identifiable, Decodable {
    @DocumentID var id: String?
    var courseId: String
    let timestamp: Timestamp
    var startingHole: Int
    var endingHole: Int
    var currentHole: Int
    var numHoles: Int
    let groupJoinCode: String
    var tempRounds: [TempRound]
    var players: [User]
    var course: Course 
    
    var roundPictureUrls: [String]
    
       
}
