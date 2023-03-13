//
//  FriendsView.swift
//  ProjectGoodGood
//
//  Created by Bri Rhineer on 2/1/23.
//

import SwiftUI

struct FriendsView: View {
    @ObservedObject var viewModel = FriendsViewModel()
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                Spacer().frame(height:10)
                    //* add friends icon to the top once we get the ability to add friends to collection setup in the db
                    //header
                ZStack{
                    Text("My Friends")
                        .foregroundColor(Color.birdyColor)
                        .bold()
                        .font(.title)
                }

                ForEach(viewModel.searchableUsers) { user in
                    NavigationLink {
                        ProfileView(user: user)
                    } label: {
                        UserRowView(user: user)
                    }
                    .padding(5)
                    //*Add trash icon as button for the ability to remove friend from collection once that part of the db is setup
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .frame(width:350)
    
    }
}


struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
