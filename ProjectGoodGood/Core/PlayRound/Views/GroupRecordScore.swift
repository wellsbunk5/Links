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
                                    Spacer().frame(width:40)
                                    Text("\(tempRound.totalScore)")
                                }.frame(height:30)
                            }
                                
                        }
                        //* make this dynamic to show the users in the group sorted by score ascending
                        
//                        HStack{
//                            Text("#2")
//                            Text("Dummy User 2")
//                            Spacer().frame(width:40)
//                            Text("Stat Here")
//                        }.frame(height:30)
//                        HStack{
//                            Text("#3")
//                            Text("Dummy User 3")
//                            Spacer().frame(width:40)
//                            Text("Stat Here")
//                        }.frame(height:30)
//                        HStack{
//                            Text("#4")
//                            Text("Dummy User 4")
//                            Spacer().frame(width:40)
//                            Text("Stat Here")
//                        }.frame(height:30)
//                        HStack{
//                            Text("#5")
//                            Text("Dummy User 5")
//                            Spacer().frame(width:40)
//                            Text("Stat Here")
//                        }.frame(height:30)
                    }
                }
            }
            .frame(width: 320, height: 150)
            //for rounded corners
            .cornerRadius(10)
            
            Spacer().frame(height:50)
            //Header with Hole number and Par stat
            //*Make this dynamic
            ZStack{
                Text("Hole \(holeNum) : Par \(viewModel.selectedCourse.pars[holeNum] ?? 0)")
                    .foregroundColor(Color.birdyColor)
                    .bold()
                    .font(.title)
            }
            
            // hole score tracking box
            //*Make dynamic
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
            //*Make dynamic
            ZStack{
                Color.parColor
                    .ignoresSafeArea()
                VStack{
                    HStack {
                        if viewModel.currentHole > viewModel.startingHole {
                            Button("Prev Hole") {
                                viewModel.prevHoleGroupRound(holeScores: holeScores)
                                viewModel.playRoundPresentedViews.removeLast()
                            }
                        }

                        if viewModel.currentHole < viewModel.endingHole {
                            Button("Next Hole") {
                                viewModel.nextHoleGroupRound(holeScores: holeScores)
                                viewModel.playRoundPresentedViews.append("NextHole")
                            }
                        } else {
                            Button("Finish Round") {
                                viewModel.nextHoleGroupRound(holeScores: holeScores)
                                viewModel.playRoundPresentedViews.append("FinishRound")
                            }
                        }

                    }
//                    NavigationLink("Next Hole", value: "N")
//                        .font(.title2)
//                        .padding(10)
//                        .foregroundColor(Color.white)
                }
            }
            .frame(width: 320, height:60)
            .cornerRadius(10)
                
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
