//
//  CustomInputField.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeholderText: String
    let isSecureField: Bool
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField {
                    SecureField(placeholderText, text: $text)
                        .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 0.4))
                } else {
                    TextField(placeholderText, text: $text)
                        .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 0.4))
                }
                
            }
            
            //Divider()
                //.background(Color(.darkGray))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope", placeholderText: "Email", isSecureField: false, text: .constant(""))
    }
}
