//
//  AuthViewModel.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var loginPresentedViews = [String]()
    
    private var tempUserSession: FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }

            self.tempUserSession = user
            
            let data = [
                "email": email,
                "username": username.lowercased(),
                "fullname": fullname,
                "uid": user.uid,
                "numFollowing": 0,
                "numFollowers": 0,
                "greensInRegulation": 0,
                "totalPutts": 0,
                "totalHolesPlayed": 0,
                "roundsPlayed": 0,
                "handicap": 0,
                "totalEagle": 0,
                "totalBirdie": 0,
                "totalPar": 0,
                "totalBoggie": 0,
                "totalDouble": 0,
                "totalTriple": 0
            ]
            
            Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                self.loginPresentedViews.append("uploadImage")
            }
            
        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid).updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
    
    func navigationDestination(for path: String) -> AnyView {
        switch path {
            case "register":
                return AnyView(
                    NewUserView()
                )
            case "uploadImage":
                return AnyView(
                    AddProfilePhotoView()
                )
            default:
                return AnyView(
                    LoginView()
                )
        }
    }
}
