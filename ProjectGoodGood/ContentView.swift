//
//  ContentView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var showMenu = false
    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var playRoundViewModel = PlayRoundViewModel()
    
    var body: some View {
        if $viewModel.userSession == nil {
            NavigationStack(path: $viewModel.loginPresentedViews) {
                LoginView2()
            }
            
        } else {
            NavigationStack(path: $playRoundViewModel.playRoundPresentedViews) {
                ZStack(alignment: .topLeading) {
                    MainTabView(playRoundViewModel: playRoundViewModel)
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
                        .offset(x: showMenu ?  150 : 500, y: 0) // was 0 : -300, y: 0: changing it made it right aligned

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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

