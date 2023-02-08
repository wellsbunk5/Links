//
//  GolfRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI
import Kingfisher

//extension Color {
//    static let birdyColor = Color(red: 0.286, green: 0.592, blue: 0.345)
//    static let parColor = Color(red: 0.863, green: 0.643, blue: 0.278)
//    static let bogeyColor = Color(red: 0.576, green: 0.439, blue: 0.2)
//    
//    static let roundColor = Color(red: 0.898, green: 0.898, blue: 0.898)
//}

struct GolfRoundView: View {
    @ObservedObject var viewModel: GolfRoundViewModel
    
    init(golfRound: GolfRound) {
        self.viewModel = GolfRoundViewModel(golfRound: golfRound)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = viewModel.golfRound.user {
                HStack(alignment: .top, spacing: 12) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 75, height: 75)
                        .shadow(radius: 3)
                    
                    Text(user.fullname)
                        .padding()
                        .font(.title).bold()
                        .frame(width: 250, height: 75, alignment: .leading)
                }
            }
            
            Text(DateFormatter().string(from: viewModel.golfRound.timestamp.dateValue()))
                .font(.headline)
                .frame(width: 325, height: 25, alignment: .leading)
            
            HStack {
                Text(viewModel.golfRound.courseId)
                    .font(.title2)
                    .frame(width: 170, height: 25, alignment: .leading)
                
                Text("18 Holes")
                    .font(.title2)
                    .frame(width: 150, height: 25, alignment: .leading)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.roundColor)
                    .frame(width: 350, height: 200)
                
                VStack {
                    HStack {
                        ForEach(viewModel.golfRound.scores.sorted(by: <), id: \.key) { key, value in
                            VStack {
                                Text("\(key)")
                                    .frame(width: 20)
                                    .font(.caption)
                                
                                Text("\(value)")
                                    .frame(width: 20, height: 20)
                                    .fontWeight(.bold)
                                    .font(.title3)
                            }
                            
                        }
                        
                        Text(String(viewModel.golfRound.totalScore))
                            .font(.title)
                            .offset(x: 35)
                            .foregroundColor(Color.birdyColor)
                    }
                }
                .offset(y: -40)
                .offset(x: -20)
            }
            
            Text("\(viewModel.golfRound.totalScore)")
            
            HStack {
                Button {
                    viewModel.golfRound.didLike ?? false ?
                    viewModel.unlikeRound() :
                    viewModel.likeRound()
                } label: {
                    Image(systemName: viewModel.golfRound.didLike ?? false ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundColor(viewModel.golfRound.didLike ?? false ? .red : .gray)
                }
                
                Spacer ()
                
                Button {
                    // action
                } label: {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button {
                    // action
                } label: {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                }
            }
            .padding()
            .foregroundColor(.gray)
            
            Divider()
        }
        .padding()
        
        
    }
    
}

//struct GolfRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        GolfRoundView(golfRound: GolfRound(id: "123", userId: "123", courseId: "143", likes: 270, numHoles: 9, totalScore: 41, scores: [
//            "1": 3,
//            "2": 5,
//            "3": 3,
//            "4": 3,
//            "5": 3,
//            "6": 3,
//            "7": 4,
//            "8": 5,
//            "9": 3], putts: ["1": 1], roundPictureUrls: ["urlHere"]))
//    }
//}
