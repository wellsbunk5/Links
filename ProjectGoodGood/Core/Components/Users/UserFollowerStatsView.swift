//
//  UserFollowerStatsView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/19/23.
//

import SwiftUI

struct UserFollowerStatsView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 24) {
            HStack(spacing: 4) {
                Text("\(user.numFollowing)")
                    .font(.subheadline)
                    .bold()
                
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            HStack(spacing: 4) {
                Text("\(user.numFollowers)")
                    .font(.subheadline)
                    .bold()
                
                Text("Followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

//struct UserFollowerStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFollowerStatsView(user: User)
//    }
//}
