//
//  AddProfilePhotoView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/19/23.
//

import SwiftUI
import PhotosUI

struct AddProfilePhotoView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            AuthenticationHeaderView(title1: "Finish account setup.", title2: "Add a profile photo")
            
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .modifier(ProfileImageModifier())
                } else {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .modifier(ProfileImageModifier())                }
            }
            .sheet(isPresented: $showImagePicker,
                   onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .padding(.top, 44)
            
            if let selectedImage = selectedImage {
                Button {
                    viewModel.uploadProfileImage(selectedImage)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(.blue)
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:0)
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.blue))
            .scaledToFill()
            .frame(width: 180, height: 180)
            .clipShape(Circle())
        
    }
}

struct AddProfilePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AddProfilePhotoView()
    }
}
