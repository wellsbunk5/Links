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
        VStack{
            Text("Hole \(holeNum) : Par \(course.pars[holeNum] ?? 0)")
            Stepper("Score: \(score)", value: $score, in: 1...20)
            Stepper("Putts: \(putts)", value: $putts, in: 0...10)
            
            NavigationLink("Next Hole", value: "Hole \(holeNum) \(score) \(putts)")

            
        }
    }
}

//struct RecordScore_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordScore(holeNum: "1", course: Course(fullName: "The Links at Sleepy Ridge", nickname: "sleepy ridge", address: "e", city: "l", state: "e", zip: "d", totalPar: 72, pars: ["1": 4]) )
//    }
//}
