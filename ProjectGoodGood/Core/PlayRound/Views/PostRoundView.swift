//
//  PostRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 2/2/23.
//

import SwiftUI
import PhotosUI

struct PostRoundView: View {
    @State private var showLike = false
    @ObservedObject var viewModel: PlayRoundViewModel
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        if let round = viewModel.currentRound {
            ScrollView {
                VStack {
                    ZStack {
                        Text("Round Stats")
                            .foregroundColor(Color.birdyColor)
                            .bold()
                            .font(.title)
                    }

                    ZStack {
                        Color(.systemGray)
                            .ignoresSafeArea()
                        HStack{
                            Text("Greens in Reg")
                                .colorInvert()
                                .bold()
                                .font(.title2)
                            Text("   ")
                            HStack{
                                Text("\(round.greensInRegulation)")
                                    .foregroundColor(Color(.systemOrange))
                                    .bold()
                            }
                       }
                    }
                    .frame(width: 320, height: 80)
                    .cornerRadius(10)
                    
                    ZStack {
                        Color(.systemGray)
                            .ignoresSafeArea()
                        HStack{
                            Text("Score Distribution")
                                .colorInvert()
                                .bold()
                                .font(.title2)
                            Text("   ")
                            HStack{
                                Text("Score goes here")
                                    .foregroundColor(Color(.systemOrange))
                                    .bold()
                            }
                       }
                    }
                    .frame(width: 320, height: 80) //was 120
                    .cornerRadius(10)
                    
                    ZStack {
                        Color(.systemGray)
                            .ignoresSafeArea()
                        HStack{
                            Text("Average Putts")
                                .colorInvert()
                                .bold()
                                .font(.title2)
                            Text("   ")
                            HStack{
                                Text("\(round.totalPutts / round.numHoles)")
                                    .foregroundColor(Color(.systemOrange))
                                    .bold()
                            }
                       }
                    }
                    .frame(width: 320, height: 80)
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    

                    Divider()
                    ZStack {
                        Text("Scorecard")
                            .foregroundColor(Color.birdyColor)
                            .bold()
                            .font(.title)
                        
                    }

                        
                    GolfRoundView(golfRound: round)
//                    HStack {
//
//                        ForEach(0..<selectedImages.count, id: \.self) { i in
//                              selectedImages[i]
//                                  .resizable()
//                                  .scaledToFit()
//                                  .frame(width: 100, height: 100)
//                          }
//
//
//                        PhotosPicker("Select images", selection: $selectedItems, matching: .images)
//
//                    }
//                    .onChange(of: selectedItems) { _ in
//                        Task {
//                            selectedImages.removeAll()
//
//                            for item in selectedItems {
//                                if let data = try? await item.loadTransferable(type: Data.self) {
//                                    if let uiImage = UIImage(data: data) {
//                                        let image = Image(uiImage: uiImage)
//                                        selectedImages.append(image)
//                                    }
//                                }
//                            }
//                        }
//                    }
                    

                    
                    ZStack{
                        Color.parColor
                            .ignoresSafeArea()
                        VStack{
                            Button {
//                                viewModel.postRound(round)
                                viewModel.playRoundPresentedViews = []
                                viewModel.selectedCourse = nil
                            } label: {
                                Text("Post Round")
                                    .font(.title2)
                                    .padding(10)
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .frame(width: 320, height:60)
                    .cornerRadius(10)
                }
            }
        }
    }

//    func loadImage() async {
//        guard let selectedImage = selectedImage else { return }
//        if let data = try? await selectedImage.loadTransferable(type: Data.self) {
//            let image = UIImage(data: data)
//            guard let image = image else { return }
//            images.append(image)
//        }
//
//    }
}

//struct PostRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostRoundView()
//    }
//}
