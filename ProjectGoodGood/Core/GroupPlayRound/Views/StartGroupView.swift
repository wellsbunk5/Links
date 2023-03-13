//
//  StartGroupView.swift
//  ProjectGoodGood
//
//  Created by Bri Rhineer on 3/13/23.
//

import SwiftUI

struct StartGroupView: View {
    var body: some View {
        VStack{
            ZStack{
                Text("Start Group View Model")
                    .foregroundColor(Color.birdyColor)
                    .bold()
                    .font(.title)
                    .padding([.bottom],35)
            }
            Text("They need to pick a course to play first")
            Text("Need to create group in the StartGroupViewModel and show the Join Code here")
            Text("Also need to add the ability to dynamically show users in the group as they add the join code")
            ZStack{
                Color.parColor
                    .ignoresSafeArea()
                VStack{
                    NavigationLink("Start Round", destination: GroupRecordScore(holeNum: "1", course: Course(fullName: "The Links at Sleepy Ridge", nickname: "sleepy ridge", address: "e", city: "l", state: "e", zip: "d", totalPar: 72, pars: ["1": 4])))
                        .font(.title3)
                        .padding(10)
                        .foregroundColor(Color.white)
                }
            }
            .frame(width: 150, height:40)
            .cornerRadius(10)
        }
    }
}

struct StartGroupView_Previews: PreviewProvider {
    static var previews: some View {
        StartGroupView()
    }
}
