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
                
                if viewModel.selectedCourse != nil {
                    Text(viewModel.selectedCourse?.nickname ?? "No Course Selected")
                    NavigationLink("Front 9", value: "Start 1 9 0")
                    NavigationLink("Back 9", value: "Start 10 18 0")
                    NavigationLink("Full 18", value: "Start 1 18 0")
                    Button {
                        viewModel.selectedCourse = nil
                    } label: {
                        Text("Back")
                    }
                    
                } else {
                    Text("Courses")
                    
                    ForEach(viewModel.golfCourses) { course in
                        Button {
                            viewModel.selectedCourse = course
                        } label: {
                            Text(course.nickname)
                        }
                    }
                }

                
                
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
