//
//  GroupPlayWaitingView.swift
//  ProjectGoodGood
//
//  Created by Bri Rhineer on 3/13/23.
//

import SwiftUI

struct GroupPlayWaitingView: View {
    var body: some View {
        ZStack{
                //*Make this dynamic
            Text("[Group Code] Waiting Room")
                .foregroundColor(Color.birdyColor)
                .bold()
                .font(.title)
                .padding([.bottom],35)
            Text("Please wait for your friend to start the round.")
            Text("To Do: once the host has started the round auto go to the next page. Button below is a placeholder")
                //*once the host has started the round auto go to the next page. Button below is a placeholder
            ZStack{
                Color.doubleBogeyColor
                    .ignoresSafeArea()
                VStack{
                    NavigationLink("TempGroupRecordScore", destination: GroupRecordScore(holeNum: "1", course: Course(fullName: "The Links at Sleepy Ridge", nickname: "sleepy ridge", address: "e", city: "l", state: "e", zip: "d", totalPar: 72, pars: ["1": 4])))
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

struct GroupPlayWaitingView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPlayWaitingView()
    }
}
