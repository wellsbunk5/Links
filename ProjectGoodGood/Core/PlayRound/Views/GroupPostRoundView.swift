//
//  StartGroupView.swift
//  ProjectGoodGood
//
//  Created by Bri Rhineer on 3/13/23.
//

import SwiftUI

struct GroupPostRoundView: View {
    var viewModel: PlayRoundViewModel
    var rounds: [GolfRound]
    var body: some View {
        VStack {
            ScrollView {
                VStack{
                    ZStack {
                        Text("Scorecard")
                            .foregroundColor(Color.birdyColor)
                            .bold()
                            .font(.title)

                    }
                    
                    ForEach(rounds, id: \.userId) { round in
                        GolfRoundView(golfRound: round)
                    }

                }
            }
            
            Button {
                viewModel.playRoundPresentedViews.removeLast()
            } label: {
                Text("Previous Hole")
            }
            
            Button("Post Rounds") {
                viewModel.postGroupRounds(rounds)
            }
            .toolbar(.hidden)
        }

    }
}

//struct GroupPostRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupPostRoundView()
//    }
//}
