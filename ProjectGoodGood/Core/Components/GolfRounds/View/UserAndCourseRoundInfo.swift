//
//  UserAndCourseRoundInfo.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 3/27/23.
//

import SwiftUI
import Kingfisher
import Firebase

struct UserAndCourseRoundInfo: View {
    let user: User
    let course: Course
    let viewModel: GolfRoundViewModel
    var dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .shadow(radius: 3)
                VStack(alignment: .leading){
                    Text(user.fullname)
                        .font(.title2).bold()
                    Text(viewModel.golfRound.timestamp.dateValue(), style: .date)
                        .font(.caption)
                }
                .frame(width: 250, height: 50, alignment: .topLeading)
                .padding([.bottom],10)
            }

            HStack {
                Text(course.nickname)
                    .font(.title2)
                    .frame(width: 170, height: 25, alignment: .leading)
                
                Text("\(viewModel.golfRound.numHoles) Holes")
                    .font(.title2)
                    .frame(width: 150, height: 25, alignment: .leading)
            }
        }
    }
}


