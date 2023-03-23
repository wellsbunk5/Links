//
//  StartRoundViewModel.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 3/14/23.
//

import Foundation

class StartRoundViewModel: ObservableObject {
    @Published var selectedCourse: Course?
    @Published var showJoinCodeAlert = false
    @Published var holesToPlay: Holes = .front
    @Published var joinCode = ""
    
    var tempGroup : TempGroup?
//    @Published var showPlayRoundSheet = false
    
    var roundType: RoundType = .solo
    
    var golfCourses = [Course]()
    let courseService = GolfCourseService()
    let roundService = GolfRoundService()

    
    init() {
        self.fetchCourses()
    }
    
    func fetchCourses() {
        courseService.fetchCourses { courses in
            self.golfCourses = courses
        }
    }
    
    func checkJoinCode(){
        let lowercasedCode = joinCode.uppercased()
        roundService.getTempGroup(by: lowercasedCode) { groupToJoin in
            self.tempGroup = groupToJoin
        }
    }
}

enum RoundType {
    case solo
    case withFriends
}


enum Holes {
    case front
    case back
    case full
}