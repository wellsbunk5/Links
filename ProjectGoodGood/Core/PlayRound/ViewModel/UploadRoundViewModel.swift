//
//  UploadRoundViewModel.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/20/23.
//

import Foundation

class UploadRoundViewModel: ObservableObject {
    
    let service = GolfRoundService()
    
    func uploadRound() {
        service.uploadRound()
    }
}
