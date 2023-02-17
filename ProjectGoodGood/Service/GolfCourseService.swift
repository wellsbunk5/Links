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
    
//    func fetchCourse (courseId: String) {
//        let courseRef = Firestore.firestore().collection("courses").document(courseId)
//
//        courseRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let data = document.data()
//
//                let fullName = data?["fullName"] as? String ?? ""
//                let nickname = data?["nickname"] as? String ?? ""
//                let address = data?["address"] as? String ?? ""
//                let city = data?["city"] as? String ?? ""
//                let state = data?["state"] as? String ?? ""
//                let zip = data?["zip"] as? String ?? ""
//                let totalPart = data?["totalPar"] as? Int ?? 0
//                let pars = data?["pars"]
//
//            } else {
//                print("Document does not exist.")
//            }
//        }
//    }
}
