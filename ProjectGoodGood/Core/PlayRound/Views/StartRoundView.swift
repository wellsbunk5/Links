//
//  PlayRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI

struct StartRoundView: View {
    @State var showPlayRoundSheet = false
    @ObservedObject var viewModel = StartRoundViewModel()
    
    var body: some View {
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
                                    .frame(width: 320,height:35)
                                    .padding([.top],10)
                                    .font(.title2)
                                    .foregroundColor(viewModel.holesToPlay == .front ? Color.white : Color.parColor)
                                    .background( viewModel.holesToPlay == .front ? Color.parColor : .clear)
                            }
                            Divider()
                                .overlay(Color.darkGreyColor)
                            
                            Button {
                                viewModel.holesToPlay = .back
                            } label: {
                                Text("Back 9")
                                    .frame(width: 320,height:40)
                                    .font(.title2)
                                    .foregroundColor(viewModel.holesToPlay == .back ? Color.white : Color.parColor)
                                    .background( viewModel.holesToPlay == .back ? Color.parColor : .clear)

                            }
                            Divider()
                                .overlay( Color.darkGreyColor)
                            
                            Button {
                                viewModel.holesToPlay = .full
                            } label: {
                                Text("Full 18")
                                    .frame(width: 320,height:35)
                                    .padding([.bottom],10)
                                    .font(.title2)
                                    .foregroundColor(viewModel.holesToPlay == .full ? Color.white : Color.parColor)
                                    .background( viewModel.holesToPlay == .full ? Color.parColor : .clear)

                            }
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
                            if viewModel.golfCourses.count >= 1 {
                                ForEach(viewModel.golfCourses) { course in
                                    HStack{
                                        Button {
                                            viewModel.selectedCourse = course
                                        } label: {
                                            Text(course.nickname)
                                                .font(.title2)
                                                .foregroundColor(Color.parColor)
                                                .frame(width: 270, height: 60)
                                        }
                                        Button {
                                            viewModel.selectedCourse = course
                                        } label: {
                                            Image(systemName: "arrow.forward")
                                        }

                                    }

                                }
                            } else {
                                Button {
                                    viewModel.fetchCourses()
                                } label: {
                                    Text("Load More Courses")
                                }
                            }

                        }
                    }
                    .frame(width: 320, height: max(CGFloat(viewModel.golfCourses.count) * 60, 60))
                    .cornerRadius(10)
                }
                Spacer()
                
                if viewModel.selectedCourse != nil {
                    HStack(spacing: 10){
                        //Start Group Button
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
                        
                        //Play Round Button
                        ZStack{
                            Color.parColor
                                .ignoresSafeArea()
                            VStack{
                                Button{
                                    viewModel.roundType = RoundType.solo
                                    showPlayRoundSheet = true
                                } label:{
                                    Text("Play Round")
                                        .font(.title3)
                                        .padding(10)
                                        .foregroundColor(Color.white)
                                }
                            }
                        }
                        .frame(width: 150, height:40)
                        .cornerRadius(10)
                        
                    }
                    .padding(.bottom, 50)
                } else {
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
                        }
                        .fullScreenCover(isPresented: $showPlayRoundSheet, onDismiss: clearTempRound) {
                            PlayRoundView(startRoundViewModel: viewModel, showPlayRoundModal: $showPlayRoundSheet)
                        }
                    }
                    .frame(width: 150, height:40)
                    .cornerRadius(10)
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
                    }

                    HStack(spacing: 10){
                        
                        ZStack{
                            Color.lightGreyColor
                                .ignoresSafeArea()
                            VStack{
                                Text("Start Group")
                                    .font(.title3)
                                    .padding(10)
                                    .foregroundColor(Color.white)
                            }
                        }
                        .frame(width: 150, height:40)
                        .cornerRadius(10)
                        
                        ZStack{
                            Color.lightGreyColor
                                .ignoresSafeArea()
                            VStack{
                                Text("Play Round")
                                    .font(.title3)
                                    .padding(10)
                                    .foregroundColor(Color.white)
                            }
                        }
                        .frame(width: 150, height:40)
                        .cornerRadius(10)

                        
                    }
                    .padding(.bottom, 50)
                }
            }
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
