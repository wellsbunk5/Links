//
//  StatsView2.swift
//  ProjectGoodGood
//
//  Created by Owen Hansen on 3/21/23.
//

import SwiftUI
import Charts

struct Strokes: Identifiable {
    let score: String
    let count: Int
    
    var id: String {score}
}

let data: [Strokes] = [
    .init(score: "Eagle", count: 1),
    .init(score: "Birdie", count: 5),
    .init(score: "Par", count: 24),
    .init(score: "Bogey", count: 16),
    .init(score: "Double Bogey", count: 6),
    .init(score: "Triple Bogey", count: 3)
]

struct StatsView2: View {
        var body: some View {
        VStack(){
            //shift the title down
            Spacer().frame(height:10)
            //Profile Header
            ZStack(){
                Text("Profile Stats")
                    .foregroundColor(Color.birdyColor)
                    .bold()
                    .font(.title)
            }

            //Greens in Regulation
            ZStack(){
                Color(.systemGray)
                    .ignoresSafeArea()
                HStack{
                    Text("Total Rounds:")
                        .colorInvert()
                        .bold()
                        .font(.title2)
                    Text("   ")
                    //*need to make this dynamic with user.[statname]
                    HStack{
                        Text("2")
                            .foregroundColor(Color(.systemOrange))
                            .bold()
                    }
               }
            }
            .frame(width: 320, height: 120)
            //for rounded corners
            .cornerRadius(10)
            
            ZStack{
                Chart {
                    ForEach(data) { element in
                        BarMark(
                            x: .value("Score", element.score),
                            y: .value("Count", element.count)
                        )
                        .annotation(position: .top, alignment: .top, spacing: 2.0){
                            Text("\(element.count)")
                                .font(.caption)
                                .foregroundColor(Color.birdyColor)
                                .fontWeight(.bold)
                        }
                    }
                }
                .foregroundStyle(Color.birdyColor)
                
            }
            .frame(width:320)


            //Scoring
//            ZStack(){
//                Color(.systemGray)
//                    .ignoresSafeArea()
//
//            }
//            .frame(width: 320, height: 320)
//            //for rounded corners
//            .cornerRadius(10)


            Spacer()
        }
    }
}

struct StatsView2_Previews: PreviewProvider {
    static var previews: some View {
        StatsView2()
    }
}
