//
//  PostRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 2/2/23.
//

import SwiftUI

struct PostRoundView: View {
    @ObservedObject var viewModel: PlayRoundViewModel
    
    var body: some View {
        if let round = viewModel.currentRound {
            VStack {
                Button {
                    viewModel.postRound(round)
                    viewModel.playRoundPresentedViews = []
                } label: {
                    Text("Post Round")
                }
                
//                NavigationLink("Post Round", value: "Post")
                
                Divider()
                Text("Round Details")
                Text("Scores")
                ForEach(round.scores.sorted(by: >), id: \.key) { key, score in
                    Text("Hole \(key): \(score)")
                }
            }
        }
    }
}

//struct PostRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostRoundView()
//    }
//}
