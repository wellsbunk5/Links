//
//  SideMenuRowView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/19/23.
//

import SwiftUI

struct SideMenuOptionRowView: View {
    let option: SideMenuViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: option.imageName)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(option.description)
                .foregroundColor(.black)
                .font(.subheadline)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SideMenuOptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionRowView(option: .profile)
        SideMenuOptionRowView(option: .stats)
        SideMenuOptionRowView(option: .friends)
    }
}
