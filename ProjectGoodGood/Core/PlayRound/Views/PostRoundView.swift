//
//  PostRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 2/2/23.
//

import SwiftUI
import PhotosUI

struct PostRoundView: View {
//    @State private var selectedItems = [PhotosPickerItem]()
//    @State private var selectedImages = [Image]()
    var viewModel: PlayRoundViewModel
    var round: GolfRound

    
    var body: some View {
//        VStack {
//            Text("Post Round")
//
//        }
            ScrollView {
                VStack {
                    ZStack {
                        Text("Round Stats")
                            .foregroundColor(Color.birdyColor)
                            .bold()
                            .font(.title)
                    }

                    ZStack {
                        Color.darkGreyColor
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
                        Color.darkGreyColor
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
                        Color.darkGreyColor
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
                        .padding()

////                    HStack {
////
////                        ForEach(0..<selectedImages.count, id: \.self) { i in
////                              selectedImages[i]
////                                  .resizable()
////                                  .scaledToFit()
////                                  .frame(width: 100, height: 100)
////                          }
////
////
////                        PhotosPicker("Select images", selection: $selectedItems, matching: .images)
////
////                    }
////                    .onChange(of: selectedItems) { _ in
////                        Task {
////                            selectedImages.removeAll()
////
////                            for item in selectedItems {
////                                if let data = try? await item.loadTransferable(type: Data.self) {
////                                    if let uiImage = UIImage(data: data) {
////                                        let image = Image(uiImage: uiImage)
////                                        selectedImages.append(image)
////                                    }
////                                }
////                            }
////                        }
////                    }

                    
                    HStack{
                        ZStack {
                            Color.darkGreyColor
                                .ignoresSafeArea()
                            Button {
                                viewModel.playRoundPresentedViews.removeLast()
                            } label: {
                                Text("Previous")
                                    .frame(width: 106.7, height:60)
                            }
                        }
                        .frame(width: 106.7, height:60)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        
                        ZStack{
                            Color.parColor
                                .ignoresSafeArea()
                            VStack{
                                Button {
                                    viewModel.postRound(round)
                                } label: {
                                    Text("Post Round")
                                        .frame(width: 213.3, height:60)
                                }
                            }
                        }
                        .frame(width: 213.3, height:60)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    }
                }
            }
            .toolbar(.hidden)
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
