//
//  StatsView2.swift
//  ProjectGoodGood
//
//  Created by Owen Hansen on 3/21/23.
//

import SwiftUI
import Charts
import Firebase

struct Strokes: Identifiable {
    let score: String
    let count: Int
    
    var id: String {score}
}

struct StatsView2: View {
    var data: [Strokes]
    @State var user: User
    let userService = UserService()
    
    init (user: User) {
        self.user = user
        self.data = [Strokes]()
        self.data.append(Strokes(score: "Eagle", count: user.totalEagle))
        self.data.append(Strokes(score: "Birdie", count: user.totalBirdie))
        self.data.append(Strokes(score: "Par", count: user.totalPar))
        self.data.append(Strokes(score: "Bogey", count: user.totalBogey))
        self.data.append(Strokes(score: "Double Bogey", count: user.totalDouble))
        self.data.append(Strokes(score: "Triple Bogey", count: user.totalTriple))
    }
    
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
                    HStack(alignment: .center, spacing: 8.0) {
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Total Rounds:")
                                .font(.title2.bold())
                                .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                .multilineTextAlignment(.leading)

                            Text("Average Putts:")
                                .font(.title2.bold())
                                .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                .multilineTextAlignment(.leading)
                            
                            Text("Green in Reg %:")
                                .font(.title2.bold())
                                .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                .multilineTextAlignment(.leading)

                            Text("Handicap:")
                                .font(.title2.bold())
                                .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                .multilineTextAlignment(.leading)
                        }

                        Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)

                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("\(user.roundsPlayed)")
                                .font(.title2.bold())
                                .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                .multilineTextAlignment(.leading)

                            Text("\(user.roundsPlayed > 0 ? Double(user.totalPutts) / Double(user.totalHolesPlayed) : 0.0, specifier: "%.2f" )")
                                .font(.title2.bold())
                                .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                .multilineTextAlignment(.leading)
                            
                            Text("\(user.roundsPlayed > 0 ? (Double(user.greensInRegulation) / Double(user.totalHolesPlayed)) * 100 : 0, specifier: "%.0f" )%")
                                .font(.title2.bold())
                                .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                .multilineTextAlignment(.leading)

                            Text("\(user.handicap)")
                                .font(.title2.bold())
                                .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .frame(width: 290.0, alignment: .center)
                }
                .frame(width: 320, height: 130)
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
                .padding(.top)


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

//struct StatsView2_Previews: PreviewProvider {
//    static var previews: some View {
//        StatsView2()
//    }
//}
