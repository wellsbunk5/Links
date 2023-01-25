//
//  ProfileViewModel.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/24/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var roundsPlayed = [GolfRound]()
    private let service = GolfRoundService()
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUserRounds()
    }
    
    func fetchUserRounds() {
        guard let uid = user.id else { return }
        service.fetchRounds(forUid: uid) { rounds in
            self.roundsPlayed = rounds
            
            for i in 0..<rounds.count {
                self.roundsPlayed[i].user = self.user
            }
        }
    }
}
