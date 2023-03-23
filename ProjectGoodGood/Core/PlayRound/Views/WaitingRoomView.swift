//
//  WaitingRoomView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 3/14/23.
//

import SwiftUI

struct WaitingRoomView: View {
    @ObservedObject var viewModel: PlayRoundViewModel

    
    var body: some View {
        VStack {
            ZStack{
                Text("\(viewModel.selectedCourse.nickname)")
                    .foregroundColor(Color.birdyColor)
                    .bold()
                    .font(.title)
                    .padding([.bottom],5)
                    .padding([.top],35)
            }
            
            Divider()
                .overlay(Color.darkGreyColor)
            
            Text("Join Code:")
                .foregroundColor(Color.darkGreyColor)
                .bold()
                .font(.title2)
            
                //Dynamic Join Code
            ZStack{
                Color.lightGreyColor
                    .ignoresSafeArea()
                Text("\(viewModel.tempGroup.groupJoinCode)")
                    .foregroundColor(Color.parColor)
                    .bold()
                    .font(.system(size:40))
                
            }
            .frame(width: 250, height:80)
            .cornerRadius(10)
            .padding([.bottom],10)
            
            Divider()
                .overlay(Color.darkGreyColor)
            
//            Text("\(viewModel.tempGroup.groupJoinCode)")
//                .foregroundColor(Color.parColor)
//                .bold()
//                .font(.title)

//            Text("Course: \(viewModel.selectedCourse.nickname)")
//            Text("Front 9")
            
            if viewModel.roundType == RoundType.withFriends {
                Text("Players")
                    .foregroundColor(Color.birdyColor)
                    .bold()
                    .font(.title)
                    .padding([.bottom],5)
               // Text("Players:")
                ForEach(viewModel.players, id: \.username) { player in
                    Text("\(player.fullname)")
                }
                
                Spacer().frame(height:20)
                
                ZStack{
                    Color.doubleBogeyColor
                        .ignoresSafeArea()
                    NavigationLink("Add Players", value: "SelectPlayers")
                        .font(.title2)
//                        .padding(10)
                        .foregroundColor(Color.white)
                }
                .frame(width: 150, height:40)
                .cornerRadius(10)
                .padding(10)
            }
            
            if viewModel.roundType == RoundType.withFriends && viewModel.players.count > 1 || viewModel.roundType == RoundType.solo{
                
                ZStack{
                    Color.parColor
                        .ignoresSafeArea()
                    Button {
                        viewModel.populateTempRounds()
                        viewModel.postTempGroup()
                        viewModel.playRoundPresentedViews.append("StartRound")
                    } label: {
                        Text("Start Round")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 150, height:40)
                .cornerRadius(10)
            }
            
        }
        .navigationDestination(for: String.self, destination: viewModel.navigationDestination(for:))
        Spacer()
    }
}

//struct WaitingRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        WaitingRoomView()
//    }
//}
