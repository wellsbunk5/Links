//
//  GolfRoundViewModel.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/24/23.
//

import Foundation

class GolfRoundViewModel: ObservableObject {
    @Published var golfRound: GolfRound
    private let service = GolfRoundService()
    private let courseService = GolfCourseService()
    
    init(golfRound: GolfRound) {
        self.golfRound = golfRound
        checkIfUserLikedRound()
    }
    
    func likeRound() {
        service.likeRound(golfRound) {
            self.golfRound.didLike = true
        }
    }
    
    func unlikeRound() {
        service.unlikeRound(golfRound) {
            self.golfRound.didLike = false
        }
    }
    
    func checkIfUserLikedRound() {
        service.checkIfUserLikedRound(golfRound) { didLike in
            if didLike {
                self.golfRound.didLike = true
            }
        }
    }
    
    func setCourse(courseId: String) {
        courseService.fetchCourse(withUid: courseId) {
            course in
            self.golfRound.course = course
        }
    }
    
//    func getPars(courseId: String, completion: @escaping (Dictionary<String, Int>?) -> Void) {
//        courseService.fetchCourses { courses in
//            for i in 0..<courses.count {
//                if (courses[i].id == courseId) {
//                    let pars = courses[i].pars
//                    completion(pars)
//                    return
//                }
//            }
//            completion(nil)
//        }
//    }
  
    func getPars(courseId: String) -> Dictionary<String, Int>? {
        courseService.fetchCourses { courses in
            for i in 0..<courses.count {
                if (courses[i].id == courseId) {
                    let pars = courses[i].pars
                    return pars ?? ""
                }
            }
        }
    }
    
    
    func getCourseName(courseId: String, completion: @escaping (String?) -> Void) {
        courseService.fetchCourses { courses in
            for i in 0..<courses.count {
                if (courses[i].id == courseId) {
                    let nickname = courses[i].nickname
                    completion(nickname)
                    return
                }
            }
            completion(nil)
        }
    }
}
