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
                            .padding()
                    }
                }
            }
            
            HStack{
                ZStack {
                    Color.darkGreyColor
                        .ignoresSafeArea()
                    Button {
                        viewModel.playRoundPresentedViews.removeLast()
                    } label: {
                        Text("Previous")
                            .frame(width: 106.7, height:60)
                    }
                }
                .frame(width: 106.7, height:60)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                
                ZStack{
                    Color.parColor
                        .ignoresSafeArea()
                    VStack{
                        Button {
                            viewModel.postGroupRounds(rounds)
                        } label: {
                            Text("Post Round")
                                .foregroundColor(Color.white)
                                .frame(width: 213.3, height:60)
                        }
                        //.frame(width: 213.3, height:60)
                    }
                }
                .frame(width: 213.3, height:60)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }
        }
        .toolbar(.hidden)
    }
}

//struct GroupPostRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupPostRoundView()
//    }
//}
