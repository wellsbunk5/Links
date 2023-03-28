//
//  ScoreCardView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 3/27/23.
//

import SwiftUI

struct ScoreCardView: View {
    let viewModel: GolfRoundViewModel
    let holeRange: Range<Int>
    
    var body: some View {
        VStack {
            
            if let course = viewModel.golfRound.course {
                HStack {
                    VStack {
                        Text("Hole")
                            .font(.caption)
                            .offset(y: -10)
                        
                        Text("Par")
                            .font(.caption)
                            .offset(y: -3)
                        
                        Text("Score")
                            .font(.caption)
                            .offset(y: 6)
                    }
                    .frame(width: 35)
                    
                    Divider()
                    //                    .frame(height: 70)
                        .overlay(.black)
                    
                    ForEach(1...9, id:\.self) { hole in
                        VStack {
                            Text("\(hole)")
                                .frame(width: 20)
                                .font(.caption)
                            
                            Text("\(course.pars["\(hole)"] ?? 3)")
                                .frame(width: 20, height: 10)
                                .font(.caption)
                            
                            if course.pars["\(hole)"] ?? 4 == viewModel.golfRound.scores["\(hole)"]  ?? 4 {
                                Text("\(viewModel.golfRound.scores[String(hole)] ?? 4 )")
                                    .frame(width: 20, height: 20)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.parColor)
                            }
                            else if course.pars["\(hole)"] ?? 4 < ((viewModel.golfRound.scores["\(hole)"] ?? 4)) {
                                ZStack {
                                    Rectangle()
                                        .stroke(Color.bogeyColor, lineWidth: 2)
                                        .frame(width: 22, height: 22)

                                    Text("\(viewModel.golfRound.scores["\(hole)"] ?? 4 )")
                                        .frame(width: 20, height: 20)
                                        .fontWeight(.bold)
                                        .font(.title3)
                                        .foregroundColor(Color.bogeyColor)
                                }

                            }
                            else {
                                ZStack {
                                    Circle()
                                        .stroke(Color.birdyColor, lineWidth: 2)
                                        .frame(width: 22, height: 22)

                                    Text("\(viewModel.golfRound.scores["\(hole)"]  ?? 4 )")
                                        .frame(width: 20, height: 20)
                                        .fontWeight(.bold)
                                        .font(.title3)
                                        .foregroundColor(Color.birdyColor)
                                }
                            }
                        }
                    }
                }
            }
        }
        .offset(y: -45)
    }
}

//struct ScoreCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreCardView()
//    }
//}
