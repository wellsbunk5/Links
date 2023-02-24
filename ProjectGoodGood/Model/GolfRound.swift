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
    let userId: String
    let courseId: String
    var timestamp: Timestamp
    var likes: Int
    let numHoles: Int
    var totalScore: Int
    var scores: [String : Int]
    var putts: [String: Int]
    var roundPictureUrls: [String]
    
    var greensInRegulation: Int
    var totalPutts: Int
    var totalEagle: Int
    var totalBirdie: Int
    var totalPar: Int
    var totalBogey: Int
    var totalDouble: Int
    var totalTriple: Int

    
    var user: User?
    var course: Course?
    var didLike: Bool? = false
}
