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
            Text("Join Code: \(viewModel.tempGroup.groupJoinCode)")
            Text("Course: \(viewModel.selectedCourse.nickname)")
            Text("Front 9")
            Text("Players:")
            ForEach(viewModel.players, id: \.username) { player in
                Text("\(player.fullname)")
            }
            
            NavigationLink("Add Players", value: "SelectPlayers")
            
            Button {
                viewModel.populateTempRounds()
                viewModel.postTempGroup()
                viewModel.playRoundPresentedViews.append("StartRound")
            } label: {
                Text("Start Round")
            }
            
        }
        .navigationDestination(for: String.self, destination: viewModel.navigationDestination(for:))

    }
}

//struct WaitingRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        WaitingRoomView()
//    }
//}
