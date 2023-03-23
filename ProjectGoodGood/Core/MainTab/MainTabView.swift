//  MainTabView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: MainTabs = .home
    @EnvironmentObject var authViewModel: AuthViewModel
        var body: some View {
           //if let user = authViewModel.currentUser {

            TabView(selection: $selectedTab) {
                FeedView()
                    .tabItem {
                        Label("Home",systemImage: "house")
                    }.tag(MainTabs.home)

                StartRoundView()
//                    .onTapGesture {
//                        self.selectedIndex = 2
//                    }
                    .tabItem {
                        Label("Play",systemImage: "figure.golf")
                    }.tag(MainTabs.play)
                
                ExploreView()
//                    .onTapGesture {
//                        self.selectedIndex = 1
//                    }
                    .tabItem {
                        Label("Explore",systemImage: "magnifyingglass")
                    }.tag(MainTabs.explore)
        }.accentColor(Color.parColor)
    }
}

enum MainTabs {
    case home
    case play
    case explore
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
