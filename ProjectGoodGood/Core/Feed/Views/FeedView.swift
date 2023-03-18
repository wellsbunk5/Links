//
//  FeedView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    @State private var showMenu = false
    @ObservedObject var feedViewModel = FeedViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .topLeading) {
                ScrollView {
                    LazyVStack {
                        ForEach ( feedViewModel.rounds) { golfRound in
                            GolfRoundView(golfRound: golfRound)
                                .padding()
                            
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(showMenu)
                
                if showMenu {
                    ZStack {
                        Color(.black)
                            .opacity(showMenu ? 0.25 : 0.0)
                    }.onTapGesture {
                        withAnimation(.easeInOut) {
                            showMenu = false
                        }
                    }
                    .ignoresSafeArea()
                }
                
                SideMenuView()
                    .frame(width: 300)
                    .background(showMenu ? Color.white : Color.clear)
                    .offset(x: showMenu ?  100 : 500, y: 0) // was 0 : -300, y: 0: changing it made it right aligned
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let user = viewModel.currentUser {
                        Button {
                            withAnimation(.easeInOut) {
                                showMenu.toggle()
                            }
                        } label: {
                            KFImage(URL(string: user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 32, height: 32)
                        }
                    }
                    
                }
            }
            .onAppear {
                showMenu = false
            }
        }
        .refreshable {
            feedViewModel.fetchRounds()
        }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
