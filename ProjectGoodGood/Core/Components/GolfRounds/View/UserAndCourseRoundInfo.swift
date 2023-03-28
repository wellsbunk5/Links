//
//  UserAndCourseRoundInfo.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 3/27/23.
//

import SwiftUI
import Kingfisher

struct UserAndCourseRoundInfo: View {
    let user: User
    let course: Course
    let numHoles: Int
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .shadow(radius: 3)
                
                Text(user.fullname)
                    .padding()
                    .font(.title2).bold()
                    .frame(width: 250, height: 50, alignment: .leading)
            }
            
            HStack {
                Text(course.nickname)
                    .font(.title2)
                    .frame(width: 170, height: 25, alignment: .leading)
                
                Text("\(numHoles) Holes")
                    .font(.title2)
                    .frame(width: 150, height: 25, alignment: .leading)
            }
        }
    }
}


