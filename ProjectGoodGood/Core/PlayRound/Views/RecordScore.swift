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
            //Cancel button back to FeedView() still has 'Back' button and doesn't show navigation
//            ZStack{
//                VStack{
//                    NavigationLink("Cancel", destination: FeedView())
//                        .font(.system(size: CGFloat(15)))
//                        .padding(10)
//                        .foregroundColor(Color.black)
//                }
//            }
//            .frame(width: 320, height:60)
//            .cornerRadius(10)
//            .offset(x: 85)
            
//            Spacer().frame(height:40)
            
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


            //Next hole button Link
            ZStack{
                Color.parColor
                    .ignoresSafeArea()
                
                HStack {
                    if viewModel.currentHole > viewModel.startingHole {
                        Button {
                            viewModel.prevHoleSoloRound(holeScores: holeScores)
                            viewModel.playRoundPresentedViews.removeLast()
                        } label: {
                            Text("Prev")
                        }
                    }

                    if viewModel.currentHole < viewModel.endingHole {
                        Button {
                            viewModel.nextHoleSoloRound(holeScores: holeScores)
                            viewModel.playRoundPresentedViews.append("NextHole")
                        } label: {
                            Text("Next")
                        }
                    } else {
                        Button("Finish Round") {
                            viewModel.nextHoleSoloRound(holeScores: holeScores)
                            viewModel.playRoundPresentedViews.append("FinishRound")
                        }
                    }

                }
//                VStack{
//                    NavigationLink("Next Hole", value: "NextHole")
//                        .font(.title2)
//                        .padding(10)
//                        .foregroundColor(Color.white)
//                }
            }
            .frame(width: 320, height:60)
            .cornerRadius(10)
                
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
