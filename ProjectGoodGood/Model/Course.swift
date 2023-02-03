//
//  Course.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/31/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Course:  Identifiable, Decodable {
    @DocumentID var id: String?
    let fullName: String
    let nickname: String
    let address: String
    let city: String
    let state: String
    let zip: String
    let totalPar: Int
    let pars: [String : Int]
    
}
