//  MainTabView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    @EnvironmentObject var authViewModel: AuthViewModel
    var playRoundViewModel: PlayRoundViewModel
        var body: some View {
           //if let user = authViewModel.currentUser {

            TabView(selection: $selectedIndex) {
                FeedView()
                    .onTapGesture {
                        self.selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "house")
                    }.tag(0)
                
                PlayRoundView(viewModel: playRoundViewModel)
                    .onTapGesture {
                        self.selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "figure.golf")
                    }.tag(1) //tag was 2changed position to put Play in the middle
                
                ExploreView()
                    .onTapGesture {
                        self.selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }.tag(2) //tag was 1 changed position to put Play in the middle
                
               //   Don't need in the navigation if it is present in the top
//                ProfileView(user: user)
//                    .onTapGesture {
//                        self.selectedIndex = 3
//                    }
//                    .tabItem {
//                        Image(systemName: "person")
//                    }.tag(3)
//            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(playRoundViewModel: PlayRoundViewModel())
    }
}
