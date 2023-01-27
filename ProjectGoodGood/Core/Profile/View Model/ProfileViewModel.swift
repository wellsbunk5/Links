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
    private let userService = UserService()
    @Published var user: User
    
    init(user: User) {
        self.user = user
        self.checkIfActiveUserFollows()
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
    
    func followUser(_ userToFollow: User, with activeUser: User) {
        userService.followUser(userToFollow, with: activeUser) {
            self.user.doesFollow = true
        }
    }
    
    func unfollowUser(_ userToUnfollow: User, with activeUser: User) {
        userService.unfollowUser(userToUnfollow, with: activeUser) {
            self.user.doesFollow = false
        }
    }
    
    func checkIfActiveUserFollows() {
        userService.checkIfActiveUserFollows(user) { doesFollow in
            if doesFollow {
                self.user.doesFollow = true
            }
        }
        
    }
}
