//
//  ProfileView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init(user: User) {
        self.profileViewModel = ProfileViewModel(user: user)
    }
    
    
    var body: some View {
        VStack {
            
            Text("Profile")
            HStack {
                Text(profileViewModel.user.username)
                
                if profileViewModel.user.isCurrentUser {
                    Button {
                        // Edit action
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline).bold()
                            .frame(width: 120, height: 32)
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
                    }
                } else {
                    if let activeUser = authViewModel.currentUser {
                        Button {
                            profileViewModel.user.doesFollow ?? false ? profileViewModel.unfollowUser(profileViewModel.user, with: activeUser) : profileViewModel.followUser(profileViewModel.user, with: activeUser)
                            
                        } label: {
                            Text(profileViewModel.user.doesFollow ?? false ? "Following" : "Follow")
                                .font(.subheadline).bold()
                                .frame(width: 120, height: 32)
                                .foregroundColor(.black)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
                        }
                    }
                }
            }
            UserFollowerStatsView(user: profileViewModel.user)
            Text(profileViewModel.user.fullname)
            Text(profileViewModel.user.email)
            Text(profileViewModel.user.id ?? "No Id")
            Divider()
            Text("Rounds Played")
            
            ScrollView {
                ForEach ( profileViewModel.roundsPlayed) { golfRound in
                    GolfRoundView(golfRound: golfRound)
                        .padding()
                    
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(id:NSUUID().uuidString, username: "jdoe", fullname: "John Doe", email: "jdoe@email.com", profileImageUrl: "blahblah", numFollowers: 0, numFollowing: 0))
    }
}
