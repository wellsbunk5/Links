//
//  GroupRecordScore.swift
//  ProjectGoodGood
//
//  Created by Bri Rhineer on 3/13/23.
//

import SwiftUI

struct GroupRecordScore: View {

    let holeNum: String
    @State var holeScores: [HoleScore]
    var viewModel: PlayRoundViewModel

    
    var body: some View {
        VStack{
            
            ZStack{
                Text("Live Leader Board")
                    .foregroundColor(Color.birdyColor)
                    .bold()
                    .font(.title)
            }
            
            ZStack(){
                Color.lightGreyColor
                    .ignoresSafeArea()
                ScrollView {
                    LazyVStack {
                        ForEach(0..<viewModel.tempGroup.tempRounds.count, id: \.self) { index in
                            
                            if let player = viewModel.players[index], let tempRound = viewModel.tempGroup.tempRounds[index] {
                                HStack{
                                    Text("\(player.fullname)")
                                    Spacer().frame(width:50)
                                    Text("\(tempRound.totalScore)")
                                }
                                .frame(height:30)
                                .padding(2)
                            }
                        }
                    }
                }
            }
            .frame(width: 320, height: 140)
            //for rounded corners
            .cornerRadius(10)
            
            Spacer().frame(height:30)

            //Header with Hole number and Par stat
            ZStack{
                Text("Hole \(holeNum) : Par \(viewModel.selectedCourse.pars[holeNum] ?? 0)")
                    .foregroundColor(Color.birdyColor)
                    .bold()
                    .font(.title)
            }
            
            // hole score tracking box
            ScrollView {
                ForEach(0..<holeScores.count, id: \.self) { index in
                    if let player = viewModel.players[index] {
                        Text("\(player.fullname)")
                    }
                    ZStack{
                        Color.lightGreyColor
                            .ignoresSafeArea()
                        VStack{
                            Stepper("Score: \(holeScores[index].score) ", value: $holeScores[index].score, in: 1...20)
                                .font(.title2)
                                .padding(10)
                                .foregroundColor(Color.parColor)
                            Divider()
                                .overlay(Color.darkGreyColor)
                            Stepper("Putts: \(holeScores[index].putts) ", value: $holeScores[index].putts, in: 0...10)
                                .font(.title2)
                                .padding(10)
                                .foregroundColor(Color.parColor)
                        }


                    }
                    .frame(width: 320, height: 150)
                    .cornerRadius(10)
                    .padding([.bottom],20)
                }
            }



            //Next hole button Link
            HStack {
                if viewModel.currentHole > viewModel.startingHole {
                    ZStack{
                        Color.darkGreyColor
                            .ignoresSafeArea()
                            Button {
                                viewModel.prevHoleGroupRound(holeScores: holeScores)
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
                            viewModel.nextHoleGroupRound(holeScores: holeScores)
                            viewModel.playRoundPresentedViews.append("NextHole")
                        } label: {
                            Text("Next Hole")
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
                            viewModel.nextHoleGroupRound(holeScores: holeScores)
                            viewModel.playRoundPresentedViews.append("FinishRound")
                        } label: {
                            Text("Finish Round")
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

//struct GroupRecordScore_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupRecordScore(holeNum: "1", course: Course(fullName: "The Links at Sleepy Ridge", nickname: "sleepy ridge", address: "e", city: "l", state: "e", zip: "d", totalPar: 72, pars: ["1": 4]))
//    }
//}
