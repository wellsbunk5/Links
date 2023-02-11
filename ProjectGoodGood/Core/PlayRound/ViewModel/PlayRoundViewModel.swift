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
    let userService = UserService()
    
    init() {
        self.fetchCourses()
    }
    
    func postRound(_ round: GolfRound) {
        service.postRound(round)
        userService.updateUserStats(with: round)
        
    }
    
    func fetchCourses() {
        courseService.fetchCourses { courses in
            self.golfCourses = courses
        }
    }
    
    func createHoleScore(for hole: Int, score: Int, putts: Int) {
        currentRound?.scores["\(hole)"] = score
        currentRound?.putts["\(hole)"] = putts
        currentRound?.totalScore += score
        currentRound?.totalPutts += putts
        
        let strokesToGreen = score - putts
        let holePar = selectedCourse?.pars["\(hole)"] ?? 4
        let greenInRegulationStrokes = holePar  - 2
        let strokesOverUnderPar = score - holePar
            
        if greenInRegulationStrokes >= strokesToGreen {
            currentRound?.greensInRegulation += 1
        }
        
        switch strokesOverUnderPar {
        case 1:
            currentRound?.totalBogey += 1
        case 2:
            currentRound?.totalDouble += 1
        case 3 ... 20:
            currentRound?.totalTriple += 1
        case -1:
            currentRound?.totalBirdie += 1
        case -4 ... -2 :
            currentRound?.totalEagle += 1
        default:
            currentRound?.totalPar += 1
        }
        
    }

    
    func navigationDestination(for path: String) -> AnyView {
        let parts = path.split(separator: " ")
        let holeNum = Int(parts[1]) ?? 0
        let score = Int(parts[2]) ?? 0
        let putts = Int(parts[3]) ?? 0
        
        if let selectedCourse {
            switch parts[0] {
                case "Start":
                    guard let uid = Auth.auth().currentUser?.uid else { return AnyView(Text("Not Valid User") )}
                
                self.currentRound = GolfRound(userId: uid, courseId: selectedCourse.id ?? "no Id", timestamp: Timestamp(date: Date()), likes: 0, numHoles: holeNum == 1 ? score : 9, totalScore: 0, scores: ["\(holeNum)": 0], putts: ["\(holeNum)": 0], roundPictureUrls: [String](), greensInRegulation: 0, totalPutts: 0, totalEagle: 0, totalBirdie: 0, totalPar: 0, totalBogey: 0, totalDouble: 0, totalTriple: 0)
                
                userService.fetchUser(withUid: uid, completion: { user in
                    self.currentRound?.user = user
                })
                
                    self.lastHoleNum = score
                    return AnyView( RecordScore(holeNum: "\(holeNum)", course: selectedCourse))
                
                case "Hole":
                    createHoleScore(for: holeNum, score: score, putts: putts)
                
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
