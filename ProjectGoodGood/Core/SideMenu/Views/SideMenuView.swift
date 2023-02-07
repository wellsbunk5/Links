//
//  SideMenuView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/19/23.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack(spacing: 32) {
                VStack() {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width:48, height: 48)
                    
                    VStack(spacing: 4) {
                        Text(user.fullname)
                            .font(.headline)
                        
                        Text(user.username)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    UserFollowerStatsView(user: user)
                        .padding(.vertical)
                }
                .padding()
                
                ForEach(SideMenuViewModel.allCases, id:\.rawValue) { option in
                    if option == .profile {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMenuOptionRowView(option: option)
                        }
                    } else if option == .stats {
                        NavigationLink {
                            StatsView(user: user)
                        }label: {
                            SideMenuOptionRowView(option: option)
                        }
                    } else if option == .friends {
                        NavigationLink {
                            FriendsView()
                        }label: {
                            SideMenuOptionRowView(option: option)
                        }
                    }else if option == .logout {
                        Button {
                            authViewModel.signOut()
                        } label: {
                            SideMenuOptionRowView(option: option)
                        }
                    } else {
                        SideMenuOptionRowView(option: option)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}


