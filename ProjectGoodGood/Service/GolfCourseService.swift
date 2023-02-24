//
//  GolfCourseService.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/31/23.
//

import Firebase
import FirebaseFirestoreSwift

struct GolfCourseService {
    
    func fetchCourses(completion: @escaping([Course]) -> Void) {
        let courseRef = Firestore.firestore().collection("courses")
        
        courseRef.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let courses = documents.compactMap({ try? $0.data(as: Course.self) })
            
            completion(courses)
        }
        
    }
    
    func fetchCourse(withUid courseId: String, completion: @escaping(Course) -> Void) {
        Firestore.firestore().collection("courses")
            .document(courseId)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let course = try? snapshot.data(as: Course.self) else { return }
                completion(course)
            }
    }
}
