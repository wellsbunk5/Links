//
//  PlayRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI

struct StartRoundView: View {
    @ObservedObject var viewModel = StartRoundViewModel()
    @State var showPlayRoundSheet = false
    
        //*To Be used to connect to the joinViewModel and JoinBar for searching
    //@ObservedObject var joinViewModel: JoinViewModel
    
    var body: some View {
//        NavigationStack(path: $viewModel.playRoundPresentedViews) {
            VStack {
                //Course Already Selected
                if viewModel.selectedCourse != nil {
                    Spacer().frame(height:10)
                    VStack(alignment: .leading){
                        //Back Button to no course  selected
                        VStack(alignment: .leading){
                            Button {
                                viewModel.selectedCourse = nil
                            } label: {
                                Image(systemName: "arrow.backward.circle")
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width:35, height: 35)
                                    .foregroundColor(Color.darkGreyColor)
                            }
                        }
                        //Header with selected course as title
                        ZStack{
                            Text(viewModel.selectedCourse?.nickname ?? "No Course Selected")
                                .foregroundColor(Color.birdyColor)
                                .bold()
                                .font(.title)
                        }
                        .frame(width: 320, height: 60)
                        .cornerRadius(10)
                        .padding([.bottom],20)
                    }
                        //select what holes to play at the course
                    ZStack{
                        Color.lightGreyColor
                            .ignoresSafeArea()
                        VStack{
                            Button {
                                viewModel.holesToPlay = .front
                            } label: {
                                Text("Front 9")
                                    .font(.title2)
                                    .padding(10)
                                    .foregroundColor(Color.parColor)
                                    .background( viewModel.holesToPlay == .front ? Color.bogeyColor : .clear)
                            }
                            Divider()
                                .overlay(Color.darkGreyColor)
                            
                            Button {
                                viewModel.holesToPlay = .back
                            } label: {
                                Text("Back 9")
                                    .font(.title2)
                                    .padding(10)
                                    .foregroundColor(Color.parColor)
                                    .background( viewModel.holesToPlay == .back ? Color.bogeyColor : .clear)

                            }
                            Divider()
                                .overlay( Color.darkGreyColor)
                            
                            Button {
                                viewModel.holesToPlay = .full
                            } label: {
                                Text("Full 18")
                                    .font(.title2)
                                    .padding(10)
                                    .foregroundColor(Color.parColor)
                                    .background( viewModel.holesToPlay == .full ? Color.bogeyColor : .clear)

                            }
                            Divider()
                                .overlay( Color.darkGreyColor)
                        }
                    }
                    .frame(width: 320, height: 180)
                    .cornerRadius(10)
                    
                    Spacer()

                    
                //No Course Selected: List of all the courses to select
                } else {
                    Spacer().frame(height:65)
                    //Header
                        ZStack{
                            Text("Courses")
                                .foregroundColor(Color.birdyColor)
                                .bold()
                                .font(.title)
                                .padding([.bottom],35)
                        }
                    
                    // listing out each course location
                    ZStack{
                        Color.lightGreyColor
                            .ignoresSafeArea()
                        VStack{
                            ForEach(viewModel.golfCourses) { course in
                                Button {
                                    viewModel.selectedCourse = course
                                } label: {
                                        Text(course.nickname)
                                            .font(.title2)
                                            .foregroundColor(Color.parColor)
                                            .frame(width: 320, height: 60)
                                }

                            }
                        }
                    }
                    .frame(width: 320, height: 60)
                    .cornerRadius(10)
                }
                Spacer()
                
                Button ("Play Round") {
                    viewModel.roundType = RoundType.solo
                    showPlayRoundSheet = true
                }
                
                HStack(spacing: 10){
                    //Join group play round Popup
                    ZStack{
                        Color.parColor
                            .ignoresSafeArea()
                        VStack{
                            Button("Join Round") {
                                viewModel.showJoinCodeAlert = true
                            }
                            .font(.title3)
                            .padding(10)
                            .foregroundColor(Color.white)
                            .alert("Enter Join Code", isPresented: $viewModel.showJoinCodeAlert) {
                                TextField("Join Code", text: $viewModel.joinCode)
                                HStack {
                                    Button {
                                        viewModel.showJoinCodeAlert = false
                                    }label: {
                                        Text("Cancel")
                                    }
                                    
                                    Button {
                                        viewModel.checkJoinCode()
                                        if viewModel.tempGroup != nil {
                                            showPlayRoundSheet = true
                                        }
                                    } label: {
                                        Text("Submit")
                                    }
                                }
//                            .popover(isPresented: $showingPopover) {
//                                Spacer()
//                                    .frame(height: 50)
//                                    //*connect this to the joinViewModel and JoinBar for searching
////                                    JoinBar(text: $joinViewModel.searchText)
////                                        .padding()
//                                Text("Need to connect this to the joinViewModel and JoinBar for searching/inputing the join code")
//                                    .font(.headline)
//                                    .padding()
//                                HStack(spacing: 10){
//                                        //Cancel Button
//                                    ZStack{
//                                        Color.doubleBogeyColor
//                                            .ignoresSafeArea()
//                                        Button("Cancel") {
//                                            showingPopover = false
//                                        }
//                                        .font(.title3)
//                                        .padding(10)
//                                        .foregroundColor(Color.white)
//                                    }
//                                    .frame(width: 150, height:40)
//                                    .cornerRadius(10)
//
//                                        //Join Buttom after they have entered the Join Code
//                                    //*connect this to the joinViewModel and JoinBar for searching
//                                    ZStack{
//                                        Color.parColor
//                                            .ignoresSafeArea()
//                                        VStack{
//                                            NavigationLink("Join", destination: GroupPlayWaitingView())
//                                                .font(.title3)
//                                                .padding(10)
//                                                .foregroundColor(Color.white)
//                                                .navigationBarHidden(true)
//                                        }
//                                    }
//                                    .frame(width: 150, height:40)
//                                    .cornerRadius(10)
//                                }
                            }
                        }
                    }
                    .frame(width: 150, height:40)
                    .cornerRadius(10)

                    //*Start group play round Button. They need to select a course, so maybe this is better after they have selected a course. This should be gray until the pick a course to play
                    ZStack{
                        Color.doubleBogeyColor
                            .ignoresSafeArea()
                        VStack{
                            Button("Start Group") {
                                viewModel.roundType = RoundType.withFriends
                                showPlayRoundSheet = true
                            }
                                .font(.title3)
                                .padding(10)
                                .foregroundColor(Color.white)
                        }
                    }
                    .frame(width: 150, height:40)
                    .cornerRadius(10)
                    .fullScreenCover(isPresented: $showPlayRoundSheet, onDismiss: clearTempRound) {
                        PlayRoundView(startRoundViewModel: viewModel, showPlayRoundModal: $showPlayRoundSheet)
                    }
                    
                }
                .padding(.bottom, 50)
            }
//            .navigationDestination(for: String.self, destination: viewModel.navigationDestination(for:))
//        }
    }
    
    func clearTempRound() {
        viewModel.tempGroup = nil
    }
}

struct StartRoundView_Previews: PreviewProvider {
    static var previews: some View {
        StartRoundView(viewModel: StartRoundViewModel())
    }
}
