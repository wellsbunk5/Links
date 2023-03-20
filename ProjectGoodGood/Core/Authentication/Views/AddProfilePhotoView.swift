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
        ZStack{
            Color(hue: 0.3653846153846154, saturation: 0.5165562913907286, brightness: 0.592156862745098, opacity: 1.0)
            
            VStack {
                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)
                
                Text("Finish account setup.\nAdd a profile photo.")
                    .font(.title.bold())
                    .foregroundColor(Color(uiColor: .white))
                    .multilineTextAlignment(.leading)
                
                    .padding(
                        EdgeInsets(
                            top: CGFloat(40.0),
                            leading: CGFloat(40.0),
                            bottom: CGFloat(40.0),
                            trailing: CGFloat(40.0)
                        )
                    )
                    .offset(x: 0.0, y: 0.0)
                
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
                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)
                
                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)
                
                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)
                
                if let selectedImage = selectedImage {
                    Button {
                        viewModel.uploadProfileImage(selectedImage)
                    } label: {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(Color(hue: 0.3653846153846154, saturation: 0.5165562913907286, brightness: 0.592156862745098, opacity: 1.0))
                            .frame(width: 340, height: 50)
                            .background(.white)
                            .clipShape(Capsule())
                            .padding()
                    }
                    .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:0)
                }
                
                Spacer()
            }
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
