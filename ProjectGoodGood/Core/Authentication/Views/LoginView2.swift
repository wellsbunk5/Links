//
//  LoginView2.swift
//  ProjectGoodGood
//
//  Created by Owen Hansen on 2/15/23.
//

import SwiftUI

struct LoginView2: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        ZStack{
            Color(hue: 0.3653846153846154, saturation: 0.5165562913907286, brightness: 0.592156862745098, opacity: 1.0)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 16.0) {
                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)

                Image("Links")
                    .resizable()
                    .frame(
                        width: 250.0,
                        height: 250.0
                    )
                    .padding(
                        EdgeInsets(
                            top: CGFloat(16.0),
                            leading: CGFloat(16.0),
                            bottom: CGFloat(16.0),
                            trailing: CGFloat(16.0)
                        )
                    )

                HStack(alignment: .center, spacing: 8.0) {
                    CustomInputField(imageName: "envelope", placeholderText: "Email", isSecureField: false, text: $email)
                    //Text("Email")
                        .font(.body)
                        .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 0.4))
                        .multilineTextAlignment(.leading)

                        .padding(
                            EdgeInsets(
                                top: CGFloat(16.0),
                                leading: CGFloat(16.0),
                                bottom: CGFloat(16.0),
                                trailing: CGFloat(16.0)
                            )
                        )
                        .frame(width: 250.0, height: 40.0, alignment: .leading)
                        .background(
                            ZStack {
                                RoundedRectangle(
                                    cornerRadius: 100,
                                    style: .circular
                                )
                                .fill(
                                    Color(uiColor: .clear)
                                )
                                .opacity(1.0)

                                RoundedRectangle(
                                    cornerRadius: CGFloat(100),
                                    style: .circular
                                )
                                .strokeBorder(lineWidth: CGFloat(2), antialiased: true)
                                .foregroundColor(
                                    Color(uiColor: .white)
                                )
                            }
                            .compositingGroup(),
                            alignment: .center
                        )
                }
                
                CustomInputField(imageName: "lock", placeholderText: "Password", isSecureField: true, text: $password)
                //Text("Password")
                    .font(.body)
                    .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 0.4))
                    .multilineTextAlignment(.leading)

                    .padding(
                        EdgeInsets(
                            top: CGFloat(16.0),
                            leading: CGFloat(16.0),
                            bottom: CGFloat(16.0),
                            trailing: CGFloat(16.0)
                        )
                    )
                    .frame(width: 250.0, height: 40.0, alignment: .leading)
                    .background(
                        ZStack {
                            RoundedRectangle(
                                cornerRadius: 100,
                                style: .circular
                            )
                            .fill(
                                Color(uiColor: .clear)
                            )
                            .opacity(1.0)

                            RoundedRectangle(
                                cornerRadius: CGFloat(100),
                                style: .circular
                            )
                            .strokeBorder(lineWidth: CGFloat(2), antialiased: true)
                            .foregroundColor(
                                Color(uiColor: .white)
                            )
                        }
                        .compositingGroup(),
                        alignment: .center
                    )

                HStack(alignment: .center, spacing: 8.0) {
                    NavigationLink {
                        Text("Reset password View...")
                    } label: {
                        Text("Forgot Password?")
                            .font(.caption)
                            .foregroundColor(Color(uiColor: .white))
                            .multilineTextAlignment(.trailing)
                        
                            .offset(x: 75.0, y: 0.0)
                    }
                }

                Button {
                    viewModel.login(withEmail: email, password: password)
                } label: {
                    Text("Sign In")
                        .font(.body)
                        .foregroundColor(Color(hue: 0.3653846153846154, saturation: 0.5165562913907286, brightness: 0.592156862745098, opacity: 1.0))
                        .multilineTextAlignment(.leading)

                        .frame(width: 250.0, height: 40.0, alignment: .center)
                        .background(
                            ZStack {
                                RoundedRectangle(
                                    cornerRadius: 100,
                                    style: .circular
                                )
                                .fill(
                                    Color(uiColor: .white)
                                )
                                .opacity(1.0)

                                RoundedRectangle(
                                    cornerRadius: CGFloat(100),
                                    style: .circular
                                )
                                .strokeBorder(lineWidth: CGFloat(2), antialiased: true)
                                .foregroundColor(
                                    Color(uiColor: .white)
                                )
                            }
                            .compositingGroup(),
                            alignment: .center
                        )
                }

                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)

                HStack(alignment: .center, spacing: 12.0) {
                    Text("Don't have an account?")
                        .font(.caption)
                        .foregroundColor(Color(uiColor: .white))
                        .multilineTextAlignment(.leading)

                        .offset(x: 0.0, y: 0.0)

                    Button {
                        viewModel.loginPresentedViews.append("register")
                    } label: {
                        Text("Sign Up")
                            .font(.subheadline)
                            .foregroundColor(Color(uiColor: .white))
                            .multilineTextAlignment(.leading)

                            .frame(alignment: .bottom)
                    }
                }
                .padding(
                    EdgeInsets(
                        top: CGFloat(20.0),
                        leading: CGFloat(20.0),
                        bottom: CGFloat(20.0),
                        trailing: CGFloat(20.0)
                    )
                )
                .frame(alignment: .bottom)
            }
            .navigationDestination(for: String.self, destination:
                                    viewModel.navigationDestination(for:))
        }
    }
}

struct LoginView2_Previews: PreviewProvider {
    static var previews: some View {
        LoginView2()
    }
}
