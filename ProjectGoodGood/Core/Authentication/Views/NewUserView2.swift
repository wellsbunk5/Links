//
//  NewUserView2.swift
//  ProjectGoodGood
//
//  Created by Owen Hansen on 2/15/23.
//

import SwiftUI

struct NewUserView2: View {
    var body: some View {
        ZStack{
            Color(hue: 0.3653846153846154, saturation: 0.5165562913907286, brightness: 0.592156862745098, opacity: 1.0)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 16.0) {
                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)

                Text("Get Started.\nCreate Your Account.")
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

                Text("Email")
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

                Text("Username")
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

                Text("Full Name")
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

                Text("Password")
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

                Text("Sign Up")
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

                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)

                HStack(alignment: .center, spacing: 12.0) {
                    Text("Already have an account?")
                        .font(.caption)
                        .foregroundColor(Color(uiColor: .white))
                        .multilineTextAlignment(.leading)

                        .offset(x: 0.0, y: 0.0)

                    Text("Sign In")
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: .white))
                        .multilineTextAlignment(.leading)

                        .frame(alignment: .bottom)
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

        }
    }
}

struct NewUserView2_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView2()
    }
}
