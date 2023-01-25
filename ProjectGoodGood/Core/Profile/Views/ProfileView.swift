//
//  ProfileView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileViewModel: ProfileViewModel
    
    init(user: User) {
        self.profileViewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            
            Text("Profile")
            Text(profileViewModel.user.username)
            Text(profileViewModel.user.fullname)
            Text(profileViewModel.user.email)
            Text(profileViewModel.user.id ?? "No Id")
            Divider()
            Text("Rounds Played")
            
            ForEach ( profileViewModel.roundsPlayed) { golfRound in
                GolfRoundView(golfRound: golfRound)
                    .padding()
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(id:NSUUID().uuidString, username: "jdoe", fullname: "John Doe", email: "jdoe@email.com", profileImageUrl: "blahblah"))
    }
}
