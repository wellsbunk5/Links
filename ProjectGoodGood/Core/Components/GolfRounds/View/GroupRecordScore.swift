//
//  GroupRecordScore.swift
//  ProjectGoodGood
//
//  Created by Bri Rhineer on 3/13/23.
//

import SwiftUI

struct GroupRecordScore: View {
    @State var score: Int = 1
    @State var putts: Int = 0
    let holeNum: String
    let course: Course
    
    var body: some View {
        VStack{
            //Cancel button back to FeedView() still has 'Back' button and doesn't show navigation
            ZStack{
                VStack{
                    NavigationLink("Cancel", destination: FeedView())
                        .font(.system(size: CGFloat(15)))
                        .padding(10)
                        .foregroundColor(Color.black)
                }
            }
            .frame(width: 320, height:60)
            .cornerRadius(10)
            .offset(x: 85)
            
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
                        //* make this dynamic to show the users in the group sorted by score ascending
                        HStack{
                            Text("#1")
                            Text("Dummy User 1")
                            Spacer().frame(width:40)
                            Text("Stat Here")
                        }.frame(height:30)
                        HStack{
                            Text("#2")
                            Text("Dummy User 2")
                            Spacer().frame(width:40)
                            Text("Stat Here")
                        }.frame(height:30)
                        HStack{
                            Text("#3")
                            Text("Dummy User 3")
                            Spacer().frame(width:40)
                            Text("Stat Here")
                        }.frame(height:30)
                        HStack{
                            Text("#4")
                            Text("Dummy User 4")
                            Spacer().frame(width:40)
                            Text("Stat Here")
                        }.frame(height:30)
                        HStack{
                            Text("#5")
                            Text("Dummy User 5")
                            Spacer().frame(width:40)
                            Text("Stat Here")
                        }.frame(height:30)
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
                Text("Hole 1 : Par 2")
                    .foregroundColor(Color.birdyColor)
                    .bold()
                    .font(.title)
            }
            
            // hole score tracking box
            //*Make dynamic
            ZStack{
                Color.lightGreyColor
                    .ignoresSafeArea()
                VStack{
                    Stepper("Score: 2", value: $score, in: 1...20)
                        .font(.title2)
                        .padding(10)
                        .foregroundColor(Color.parColor)
                    Divider()
                        .overlay(Color.darkGreyColor)
                    Stepper("Putts: 0", value: $putts, in: 0...10)
                        .font(.title2)
                        .padding(10)
                        .foregroundColor(Color.parColor)

                }
            }
            .frame(width: 320, height: 150)
            .cornerRadius(10)
            .padding([.bottom],20)

            //Next hole button Link
            //*Make dynamic
            ZStack{
                Color.parColor
                    .ignoresSafeArea()
                VStack{
                    NavigationLink("Next Hole", value: "Hole 2")
                        .font(.title2)
                        .padding(10)
                        .foregroundColor(Color.white)
                }
            }
            .frame(width: 320, height:60)
            .cornerRadius(10)
                
            Spacer()

        }
    }
}

struct GroupRecordScore_Previews: PreviewProvider {
    static var previews: some View {
        GroupRecordScore(holeNum: "1", course: Course(fullName: "The Links at Sleepy Ridge", nickname: "sleepy ridge", address: "e", city: "l", state: "e", zip: "d", totalPar: 72, pars: ["1": 4]))
    }
}
