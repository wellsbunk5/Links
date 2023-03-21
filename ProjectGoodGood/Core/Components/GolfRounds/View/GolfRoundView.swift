//
//  GolfRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI
import Kingfisher

struct GolfRoundView: View {
    @State private var showLikeComment = true
    @ObservedObject var viewModel: GolfRoundViewModel
    
    init(golfRound: GolfRound) {
        self.viewModel = GolfRoundViewModel(golfRound: golfRound)
        
        self.viewModel.setCourse(courseId: self.viewModel.golfRound.courseId)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = viewModel.golfRound.user {
                HStack(alignment: .top, spacing: 12) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                        .shadow(radius: 3)
                    
                    Text(user.fullname)
                        .padding()
                        .font(.title2).bold()
                        .frame(width: 250, height: 50, alignment: .leading)
                }
            }

            //Text for date not appearing
            Text(DateFormatter().string(from: viewModel.golfRound.timestamp.dateValue()))
                .font(.headline)
                .frame(width: 325, height: 25, alignment: .leading)
            
             //* Caption for Post, need to make this dynamic and optional for the post round
            VStack{
                if showLikeComment == true{
                    Text("Placeholder for caption. Realistically this will be a couple lines pulling from the database that someone will add when the are on the 'Post Round' view.")
                      .font(.system(size:12))
                }
                    //show input box *Need to connect this to the backend
                else{
                    Text("Replace with input field")
                        .font(.system(size:12))
//                    CustomInputField(imageName: "bubble.left", placeholderText: "Comment", isSecureField: false, text:$comment)
                }
            }
            
            if let course = viewModel.golfRound.course {
                HStack {
                    Text(course.nickname)
                        .font(.title2)
                        .frame(width: 170, height: 25, alignment: .leading)
                    
                    Text("\(viewModel.golfRound.numHoles) Holes")
                        .font(.title2)
                        .frame(width: 150, height: 25, alignment: .leading)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.roundColor)
                        .frame(width: 350, height: 200)
                    
                    if viewModel.golfRound.scores.count == 9 {
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
            
            if showLikeComment == true{
                HStack {
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
                    Button {
                        // action
                    } label: {
                        Image(systemName: "bubble.left")
                            .font(.subheadline)
                    }
                    
                }
                .padding(1)
                .foregroundColor(.gray)
            }
            Divider()
        }
        //.padding() //remove spacing between Posts

        
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
