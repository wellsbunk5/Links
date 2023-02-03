//
//  FeedViewModel.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/20/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var rounds = [GolfRound]()
    let service = GolfRoundService()
    let userService = UserService()
    
    init() {
        fetchRounds()
    }
    
    func fetchRounds() {
        service.fetchRounds { rounds in
            self.rounds = rounds
            
            for i in 0..<rounds.count {
                let uid = rounds[i].userId
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.rounds[i].user = user
                }
            }
        }
    }
}
