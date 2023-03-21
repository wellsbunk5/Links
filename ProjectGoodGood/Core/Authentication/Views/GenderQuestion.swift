//
//  GenderQuestion.swift
//  ProjectGoodGood
//
//  Created by Owen Hansen on 2/15/23.
//

import SwiftUI

struct GenderQuestion: View {
    @State private var gender = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color(hue: 0.3653846153846154, saturation: 0.5165562913907286, brightness: 0.592156862745098, opacity: 1.0)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 8.0) {
                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)

                Text("Help us get to know you")
                    .font(.title.bold())
                    .foregroundColor(Color(uiColor: .white))
                    .multilineTextAlignment(.leading)

                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)

                Text("Whats your gender?")
                    .font(.title.bold())
                    .foregroundColor(Color(uiColor: .white))
                    .multilineTextAlignment(.leading)
                
            

                VStack(alignment: .center, spacing: 6.0) {
                    
                    RadioButtonGroup(items: ["Male", "Female", "Other", "Prefer Not to Say"], selectedId: "") { selected in
                                    print("Selected is: \(selected)")
                                }
                    

                }

                Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)

                HStack(alignment: .center, spacing: 8.0) {
                    Image(systemName: "circle")
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                        .font(.system(size: CGFloat(17)))

                    Image(systemName: "circle.fill")
                        .foregroundColor(Color(uiColor: .white))
                        .font(.system(size: CGFloat(17)))

                    Image(systemName: "circle")
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                        .font(.system(size: CGFloat(17)))

                    Image(systemName: "circle")
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                        .font(.system(size: CGFloat(17)))
                }

                HStack(alignment: .center, spacing: 8.0) {
                    Button {
                        viewModel.loginPresentedViews.append("ageQuestion")
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(uiColor: .white))
                            .font(.system(size: CGFloat(30)))
                            .padding(
                                EdgeInsets(
                                    top: CGFloat(16.0),
                                    leading: CGFloat(16.0),
                                    bottom: CGFloat(16.0),
                                    trailing: CGFloat(16.0)
                                )
                            )
                            .frame(alignment: .center)
                    }
                    

                    Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)
                    
                    Button {
                        viewModel.loginPresentedViews.append("freqQuestion")
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(uiColor: .white))
                            .font(.system(size: CGFloat(30)))
                            .padding(
                                EdgeInsets(
                                    top: CGFloat(16.0),
                                    leading: CGFloat(16.0),
                                    bottom: CGFloat(16.0),
                                    trailing: CGFloat(16.0)
                                )
                            )
                            .frame(alignment: .center)
                    }
                }
                .padding(
                    EdgeInsets(
                        top: CGFloat(16.0),
                        leading: CGFloat(16.0),
                        bottom: CGFloat(16.0),
                        trailing: CGFloat(20.0)
                    )
                )
            }

        }
    }
}

struct GenderQuestion_Previews: PreviewProvider {
    static var previews: some View {
        GenderQuestion()
    }
}
