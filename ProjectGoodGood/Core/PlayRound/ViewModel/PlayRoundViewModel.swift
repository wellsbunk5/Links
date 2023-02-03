//
//  UploadRoundViewModel.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/20/23.
//

import Foundation
import Firebase
import SwiftUI

class PlayRoundViewModel: ObservableObject {
    @Published var playRoundPresentedViews = [String]()
    @Published var selectedCourse: Course?
    var currentRound: GolfRound?
    var lastHoleNum = 18
    
    var golfCourses = [Course]()
    
    let service = GolfRoundService()
    let courseService = GolfCourseService()
    
    init() {
        self.fetchCourses()
    }
    
    func postRound(_ round: GolfRound) {
        service.postRound(round)
    }
    
    func fetchCourses() {
        courseService.fetchCourses { courses in
            self.golfCourses = courses
        }
    }
    
    func createHoleScore(for hole: Int, score: Int) {
        currentRound?.scores["\(hole)"] = score
        currentRound?.totalScore += score
        
    }
    
    func navigationDestination(for path: String) -> AnyView {
        let parts = path.split(separator: " ")
        let holeNum = Int(parts[1]) ?? 0
        let score = Int(parts[2]) ?? 0
        
        if let selectedCourse {
            switch parts[0] {
                case "Start":
                    guard let uid = Auth.auth().currentUser?.uid else { return AnyView(Text("Not Valid User") )}
                
                currentRound = GolfRound(userId: uid, courseId: selectedCourse.id ?? "no Id", timestamp: Timestamp(date: Date()), likes: 0, numHoles: holeNum == 1 ? score : 9, totalScore: 0, scores: ["\(holeNum)": 0], putts: ["\(holeNum)": 0], roundPictureUrls: [String]())
                
                    self.lastHoleNum = score
                    return AnyView( RecordScore(holeNum: "\(holeNum)", course: selectedCourse))
                
                case "Hole":
                    createHoleScore(for: holeNum, score: score)
                
                    if holeNum + 1 > lastHoleNum {
                        return AnyView( PostRoundView(viewModel: self))
                    } else {
                        return AnyView( RecordScore(holeNum: "\(holeNum + 1)", course: selectedCourse))
                    }


                default:
                    break
            }
        }

        return AnyView(Text("Done"))

    }
}
