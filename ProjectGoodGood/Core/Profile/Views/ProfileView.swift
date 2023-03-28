//
//  ProfileView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @ObservedObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init(user: User) {
        self.profileViewModel = ProfileViewModel(user: user)
    }
    
    
    var body: some View {
        VStack {
            //Header
            //* Add the user Image - mess around with no 'Profile' title
            ZStack(){
                Text(profileViewModel.user.fullname)
                    .foregroundColor(Color.birdyColor)
                    .bold()
                    .font(.title)
            }

                //User information and either button to edit own profile or follow/unfollow button
            VStack {
                Spacer().frame(height: 10)
                
                if profileViewModel.user.isCurrentUser {
                    Button {
                        //* Edit action - just edit full name and username
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
                            if profileViewModel.user.doesFollow ?? false {
                                authViewModel.currentUser?.numFollowing -= 1
                                profileViewModel.unfollowUser(profileViewModel.user, with: activeUser)
                            } else {
                                authViewModel.currentUser?.numFollowing += 1
                                profileViewModel.followUser(profileViewModel.user, with: activeUser)
                            }
                            
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
            
            UserFollowerStatsView(user: profileViewModel.user).frame(height: 20)
            
            Text(profileViewModel.user.username).frame(height: 20)
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer().frame(height: 20)
            Divider()

                //User rounds: *need to add Nate's scorecard component
            ScrollView {
                ForEach (profileViewModel.roundsPlayed) { golfRound in
                    GolfRoundView(golfRound: golfRound, showLikeButton: true)
                        .padding()
                    
                }
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(user: User(id:NSUUID().uuidString, username: "jdoe", fullname: "John Doe", email: "jdoe@email.com", profileImageUrl: "blahblah", numFollowers: 0, numFollowing: 0, greensInRegulation: 2, totalPutts:3, totalHolesPlayed: 7, roundsPlayed: 1 , handicap: 5, totalEagle: 3, totalBirdie: 4 , totalPar: 4, totalBogey: 2, totalDouble: 3, totalTriple: 2)).environmentObject(AuthViewModel())
//    }
//}
