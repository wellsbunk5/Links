//
//  GolfRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI
import Kingfisher

struct GolfRoundView: View {
    let golfRound: GolfRound
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = golfRound.user {
                HStack(alignment: .top, spacing: 12) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 56, height: 56)
                    
                    HStack {
                        Text(user.fullname)
                            .font(.subheadline).bold()
                        
                        Text(user.username)
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        Text("2w")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                     
                }
            }
            
            Text("\(golfRound.score)")
            
            HStack {
                Button {
                    // action
                } label: {
                    Image(systemName: "heart")
                        .font(.subheadline)
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
//        GolfRoundView(golfRound: GolfRound(id: "123", score: 70, timestamp: , uid: <#T##String#>, likes: <#T##Int#>))
//    }
//}
