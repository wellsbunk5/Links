//
//  SideMenuViewModel.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/19/23.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case stats
    case friends
    case logout
    
    var description: String {
        switch self {
        case .profile: return "Profile"
        case .stats: return "Stats"
        case .friends: return "Friends"
        case .logout: return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person"
        case .stats: return "list.bullet"
        case .friends: return "person"
        case .logout: return "arrow.left.square"
        }
    }
}
