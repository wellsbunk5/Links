//
//  RegistrationView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI

struct RegistrationView: View {

    @State private var registered = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        if viewModel.didAuthenticateUser == true {
            AddProfilePhotoView()
        } else {
            NewUserView()
        }
    }

}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
