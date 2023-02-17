//
//  StatsView.swift
//  ProjectGoodGood
//
//  Created by Bri Rhineer on 2/1/23.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    private let user: User

    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack(){
            //shift the title down
            Spacer().frame(height:100)
            //Profile Header
            ZStack(){
                Color.birdyColor
                    .ignoresSafeArea()
                Text("Profile Stats")
                    .colorInvert()
                    .bold()
                    .font(.title)
                
            }
            .frame(width: 320, height: 60)
            //for rounded corners
            .cornerRadius(10)
                
            //Greens in Regulation
            ZStack(){
                Color(.systemGray)
                    .ignoresSafeArea()
                HStack{
                    Text("Greens in Reg")
                        .colorInvert()
                        .bold()
                        .font(.title2)
                    Text("   ")
                    //*need to make this dynamic with user.[statname]
                    HStack{
                        Text("Score goes here")
                            .foregroundColor(Color(.systemOrange))
                            .bold()
                    }
               }
            }
            .frame(width: 320, height: 120)
            //for rounded corners
            .cornerRadius(10)
            
            //Scoring
            ZStack(){
                Color(.systemGray)
                    .ignoresSafeArea()
                HStack{
                    Text("Scoring")
                        .colorInvert()
                        .bold()
                        .font(.title2)
                    Text("   ")
                    //*need to make this dynamic with user.[statname]
                    HStack{
                        Text("Score goes here")
                            .foregroundColor(Color(.systemOrange))
                            .bold()
                    }
               }
            }
            .frame(width: 320, height: 120)
            //for rounded corners
            .cornerRadius(10)
            
            //Handicap
            ZStack(){
                Color(.systemGray)
                    .ignoresSafeArea()
                HStack{
                    Text("Handicap")
                        .colorInvert()
                        .bold()
                        .font(.title2)
                    Text("   ")
                    //*need to make this dynamic with user.[statname]
                    HStack{
                        Text("Score goes here")
                            .foregroundColor(Color(.systemOrange))
                            .bold()
                    }
               }
            }
            .frame(width: 320, height: 120)
            //for rounded corners
            .cornerRadius(10)
            
            //Putting
            ZStack(){
                Color(.systemGray)
                    .ignoresSafeArea()
                HStack{
                    Text("Putting")
                        .colorInvert()
                        .bold()
                        .font(.title2)
                    Text("   ")
                    //*need to make this dynamic with user.[statname]
                    HStack{
                        Text("Score goes here")
                            .foregroundColor(Color(.systemOrange))
                            .bold()
                    }
               }
            }
            .frame(width: 320, height: 120)
            //for rounded corners
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

//struct StatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatsView(user: User(id:NSUUID().uuidString, username: "jdoe", fullname: "John Doe", email: "jdoe@email.com",  profileImageUrl: "blahblah", numFollowers: 20, numFollowing: 24))
//    }
//}
