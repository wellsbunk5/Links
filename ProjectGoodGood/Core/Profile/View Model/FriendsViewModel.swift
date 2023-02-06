//
//  FriendsViewModel.swift
//  ProjectGoodGood
//
//  Created by Bri Rhineer on 2/2/23.
//

import Foundation

class FriendsViewModel: ObservableObject {
    @Published var users = [User]()
        //*we will get rid of this
    @Published var searchText = ""
        //*Query for friends in collection based on only the user logged in
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter({
                $0.username.contains(lowercasedQuery) || $0.fullname.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
        }
    }
}

