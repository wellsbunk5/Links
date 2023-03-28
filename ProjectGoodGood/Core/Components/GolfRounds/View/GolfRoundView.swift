//
//  GolfRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI
import Kingfisher

struct GolfRoundView: View {
    let showLikeButton: Bool
    
    @ObservedObject var viewModel: GolfRoundViewModel
    
    init(golfRound: GolfRound, showLikeButton: Bool) {
        self.viewModel = GolfRoundViewModel(golfRound: golfRound)
        self.showLikeButton = showLikeButton
        
        self.viewModel.setCourse(courseId: self.viewModel.golfRound.courseId)
        
        }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if let user = viewModel.golfRound.user, let course = viewModel.golfRound.course {
                UserAndCourseRoundInfo(user: user, course: course, viewModel: viewModel)
            }



            
            
            if let course = viewModel.golfRound.course {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.roundColor)
                        .frame(width: 350, height: 200)
                    
                    if viewModel.golfRound.numHoles == 9 {
                        VStack {
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
                                    .frame(height: 70)
                                    .overlay(.black)
                                
                                ForEach(viewModel.golfRound.scores.sorted(by: <), id: \.key) { key, value in
                                    VStack {
                                        Text("\(key)")
                                            .frame(width: 20)
                                            .font(.caption)
                                        
                                        Text("\(course.pars[key] ?? 3)")
                                            .frame(width: 20, height: 10)
                                            .font(.caption)
                                        
                                        if course.pars[key] == value {
                                            Text("\(value)")
                                                .frame(width: 20, height: 20)
                                                .fontWeight(.bold)
                                                .font(.title3)
                                                .foregroundColor(Color.parColor)
                                        }
                                        else if course.pars[key] ?? 4 <= (value - 1) {
                                            ZStack {
                                                Rectangle()
                                                    .stroke(Color.bogeyColor, lineWidth: 2)
                                                    .frame(width: 22, height: 22)
                                                
                                                Text("\(value)")
                                                    .frame(width: 20, height: 20)
                                                    .fontWeight(.bold)
                                                    .font(.title3)
                                                    .foregroundColor(Color.bogeyColor)
                                            }

                                        }
                                        else if course.pars[key] ?? 4 >= (value + 1) {
                                            ZStack {
                                                Circle()
                                                    .stroke(Color.birdyColor, lineWidth: 2)
                                                    .frame(width: 22, height: 22)
                                                
                                                Text("\(value)")
                                                    .frame(width: 20, height: 20)
                                                    .fontWeight(.bold)
                                                    .font(.title3)
                                                    .foregroundColor(Color.birdyColor)
                                            }
                                        }
        
                                    }
                                    
                                }
                                
                                Text(String(viewModel.golfRound.totalScore))
                                    .font(.title)
                                    .offset(x: -4, y: 20)
                                    .foregroundColor(Color.birdyColor)
                            }
                        }
                        .offset(y: -45)
                        
                    } else {
                        VStack {
                            ScrollView(.horizontal) {
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
                                    .frame(height: 70)
                                    .overlay(.black)
                                
                                ForEach (1...18, id:\.self) { hole in
                                        VStack {
                                            Text("\(hole)")
                                                .frame(width: 20)
                                                .font(.caption)
                                            
                                            Text("\(course.pars["\(hole)"] ?? 3)")
                                                .frame(width: 20, height: 10)
                                                .font(.caption)
                                            
                                            if course.pars["\(hole)"] ?? 4 == viewModel.golfRound.scores["\(hole)"] ?? 4{
                                                Text("\(viewModel.golfRound.scores["\(hole)"] ?? 4)")
                                                    .frame(width: 20, height: 20)
                                                    .fontWeight(.bold)
                                                    .font(.title3)
                                                    .foregroundColor(Color.parColor)
                                            }
                                            else if course.pars["\(hole)"] ?? 4 < viewModel.golfRound.scores["\(hole)"] ?? 4 {
                                                ZStack {
                                                    Rectangle()
                                                        .stroke(Color.bogeyColor, lineWidth: 2)
                                                        .frame(width: 22, height: 22)
                                                    
                                                    Text("\(viewModel.golfRound.scores["\(hole)"] ?? 4)")
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
                                                    
                                                    Text("\(viewModel.golfRound.scores["\(hole)"] ?? 4)")
                                                        .frame(width: 20, height: 20)
                                                        .fontWeight(.bold)
                                                        .font(.title3)
                                                        .foregroundColor(Color.birdyColor)
                                                }
                                            }
                                        }
                                }
                                
                                Text(String(viewModel.golfRound.totalScore))
                                    .font(.title)
                                    .offset(x: -2, y: 20)
                                    .foregroundColor(Color.birdyColor)
                            }
                        }
                        .frame(width: 320, height: 100)
                    }
                    .offset(y: -40)
                    .offset(x: 4)
                    }
                }
            }
            
            if viewModel.golfRound.roundPictureUrls.count > 0 {
                HStack {
                    ForEach(viewModel.golfRound.roundPictureUrls, id:\.self) {imageUrl in
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Rectangle())
                            .frame(width: 75, height: 75)
                            .padding(.horizontal, 5)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 2)
            }
            

            
            if showLikeButton == true{
                HStack {
                    Spacer()
                    //Like Button
                    Button {
                        viewModel.golfRound.didLike ?? false ?
                        viewModel.unlikeRound() :
                        viewModel.likeRound()
                    } label: {
                        Image(systemName: viewModel.golfRound.didLike ?? false ? "heart.fill" : "heart")
                            .font(.subheadline)
                            .foregroundColor(viewModel.golfRound.didLike ?? false ? .red : .gray)
                    }
                    //Comment Button
//                    Button {
//                        // action
//                    } label: {
//                        Image(systemName: "bubble.left")
//                            .font(.subheadline)
//                    }
                    
                }
                .padding(1)
                .foregroundColor(.gray)
            }
            Divider()
        }
        //.padding() //remove spacing between Posts

        
    }
    
}
