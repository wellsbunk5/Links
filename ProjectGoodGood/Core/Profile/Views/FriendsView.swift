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
                ZStack{
                    Color(.systemGreen)
                        .ignoresSafeArea()
                    Text("My Friends")
                        .colorInvert()
                        .bold()
                        .font(.title)
                }
                .frame(width: 320, height: 60)
                .cornerRadius(10)
                .padding([.bottom],20)

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