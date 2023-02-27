//
//  RecordScore.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 2/2/23.
//

import SwiftUI

struct RecordScore: View {
    @State var score: Int = 1
    @State var putts: Int = 0
    let holeNum: String
    let course: Course
    
    
    var body: some View {
        VStack(alignment: .leading){
            Spacer().frame(height:100)
            
            //Header with Hole number and Par stat
            ZStack{
                Color.birdyColor
                    .ignoresSafeArea()
                Text("Hole \(holeNum) : Par \(course.pars[holeNum] ?? 0)")
                    .colorInvert()
                    .bold()
                    .font(.title)
            }
            .frame(width: 320, height: 60)
            .cornerRadius(10)
            .padding([.bottom],20)
            
            // hole score tracking box
            ZStack{
                Color.lightGreyColor
                    .ignoresSafeArea()
                VStack{
                    Stepper("Score: \(score)", value: $score, in: 1...20)
                        .font(.title2)
                        .padding(10)
                        .foregroundColor(Color.parColor)
                    Divider()
                        .overlay(Color.darkGreyColor)
                    Stepper("Putts: \(putts)", value: $putts, in: 0...10)
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
                VStack{
                    NavigationLink("Next Hole", value: "Hole \(holeNum) \(score) \(putts)")
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


struct RecordScore_Previews: PreviewProvider {
    static var previews: some View {
        RecordScore(holeNum: "1", course: Course(fullName: "The Links at Sleepy Ridge", nickname: "sleepy ridge", address: "e", city: "l", state: "e", zip: "d", totalPar: 72, pars: ["1": 4]) )
    }
}
