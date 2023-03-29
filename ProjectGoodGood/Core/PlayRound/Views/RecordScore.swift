//
//  RecordScore.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 2/2/23.
//

import SwiftUI

struct RecordScore: View {
//    @State var score: Int = 1
//    @State var putts: Int = 0
    let holeNum: String
    @State var holeScores: HoleScore
    var viewModel: PlayRoundViewModel
    
    
    var body: some View {
        
        VStack{
            Spacer().frame(height:40)
            //Header with Hole number and Par stat
            ZStack{
                Text("Hole \(holeNum) : Par \(viewModel.selectedCourse.pars[holeNum] ?? 0)")
                    .foregroundColor(Color.birdyColor)
                    .bold()
                    .font(.title)
            }
            
            // hole score tracking box
            ZStack{
                Color.lightGreyColor
                    .ignoresSafeArea()
                    VStack{
                        Stepper("Score: \(holeScores.score)", value: $holeScores.score, in: 1...20)
                            .font(.title2)
                            .padding(10)
                            .foregroundColor(Color.parColor)
                        Divider()
                            .overlay(Color.darkGreyColor)
                        Stepper("Putts: \(holeScores.putts)", value: $holeScores.putts, in: 0...10)
                            .font(.title2)
                            .padding(10)
                            .foregroundColor(Color.parColor)

                    }
                }
                .frame(width: 320, height: 150)
                .cornerRadius(10)
                .padding([.bottom],20)


            //Back & Next hole button Link
                HStack {
                    if viewModel.currentHole > viewModel.startingHole {
                        ZStack{
                            Color.darkGreyColor
                                .ignoresSafeArea()
                                Button {
                                    viewModel.prevHoleSoloRound(holeScores: holeScores)
                                    viewModel.playRoundPresentedViews.removeLast()
                                } label: {
                                    Text("Previous")
                                        .frame(width: 106.7, height:60)
                                }
                            }
                            .frame(width: 106.7, height:60)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    }

                    if viewModel.currentHole < viewModel.endingHole {
                        ZStack{
                            Color.parColor
                                .ignoresSafeArea()
                            Button {
                                viewModel.nextHoleSoloRound(holeScores: holeScores)
                                viewModel.playRoundPresentedViews.append("NextHole \((Int(holeNum) ?? 99) + 1)")
                            } label: {
                                Text("Next")
                                    .frame(width: 213.3, height:60)
                            }
                        }
                        .frame(width: 213.3, height:60)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    } else {
                        ZStack{
                            Color.parColor
                                .ignoresSafeArea()
                            Button {
                                viewModel.nextHoleSoloRound(holeScores: holeScores)
                                viewModel.playRoundPresentedViews.append("FinishRound")
                            } label: {
                                Text("Finish")
                                    .frame(width: 213.3, height:60)
                            }
                        }
                        .frame(width: 213.3, height:60)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    }

                }

            Spacer()
        }
        .toolbar(.hidden)
    }
}

struct HoleScore {
    var score: Int
    var putts: Int
}

//struct RecordScore_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordScore(holeNum: "1", course: Course(fullName: "The Links at Sleepy Ridge", nickname: "sleepy ridge", address: "e", city: "l", state: "e", zip: "d", totalPar: 72, pars: ["1": 4]) )
//    }
//}
