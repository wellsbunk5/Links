//
//  GolfRoundViewModel.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/24/23.
//

import Foundation

class GolfRoundViewModel: ObservableObject {
    @Published var golfRound: GolfRound
    private let service = GolfRoundService()
    
    init(golfRound: GolfRound) {
        self.golfRound = golfRound
        checkIfUserLikedRound()
    }
    
    func likeRound() {
        service.likeRound(golfRound) {
            self.golfRound.didLike = true
        }
    }
    
    func unlikeRound() {
        service.unlikeRound(golfRound) {
            self.golfRound.didLike = false
        }
    }
    
    func checkIfUserLikedRound() {
        service.checkIfUserLikedRound(golfRound) { didLike in
            if didLike {
                self.golfRound.didLike = true
            }
        }
    }
}
