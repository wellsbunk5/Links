//
//  PlayRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI

struct PlayRoundView: View {
    @ObservedObject var viewModel = PlayRoundViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.playRoundPresentedViews) {
            VStack {
                //Course Already Selected
                if viewModel.selectedCourse != nil {
                    Spacer().frame(height:100)
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
                            Color.birdyColor
                                .ignoresSafeArea()
                            Text(viewModel.selectedCourse?.nickname ?? "No Course Selected")
                                .colorInvert()
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
                            NavigationLink("Front 9", value: "Start 1 9 0")
                                .font(.title2)
                                .padding(10)
                                .foregroundColor(Color.parColor)
                            Divider()
                                .overlay(Color.darkGreyColor)
                            NavigationLink("Back 9", value: "Start 10 18 0")
                                .font(.title2)
                                .padding(10)
                                .foregroundColor(Color.parColor)
                            Divider()
                                .overlay(Color.darkGreyColor)
                            NavigationLink("Full 18", value: "Start 1 18 0")
                                .font(.title2)
                                .padding(10)
                                .foregroundColor(Color.parColor)
                        }
                    }
                    .frame(width: 320, height: 180)
                    .cornerRadius(10)
                //No Course Selected: List of all the courses to select
                } else {
                    Spacer().frame(height:143)
                    //Header
                        ZStack{
                            Color.birdyColor
                                .ignoresSafeArea()
                            Text("Courses")
                                .colorInvert()
                                .bold()
                                .font(.title)
                        }
                        .frame(width: 320, height: 60)
                        .cornerRadius(10)
                        .padding([.bottom],20)
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
                                            .frame(width: 320, height: 40)
                                        //    .background(Color.parColor)
                                        // .clipShape(Capsule())
                                        //   .cornerRadius(10)
                                        //    .padding()
                                }
                               // .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:0)
                                //*use if we have multiple coursese
//                                Divider()
//                                    .overlay(Color.darkGreyColor)
                            }
                        }
                    }
                    .frame(width: 320, height: 60)
                    .cornerRadius(10)
                    
                }
                //shift everything upsquare.and.arrow.up
                Spacer()
                
            }
            .navigationDestination(for: String.self, destination: viewModel.navigationDestination(for:))
        }
    }
}

struct PlayRoundView_Previews: PreviewProvider {
    static var previews: some View {
        PlayRoundView()
    }
}
