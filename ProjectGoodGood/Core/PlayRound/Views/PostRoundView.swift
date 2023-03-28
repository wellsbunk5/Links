//
//  PostRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 2/2/23.
//

import SwiftUI
import PhotosUI

struct PostRoundView: View {
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
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
                    
                    ZStack(){
                        Color(.systemGray)
                            .ignoresSafeArea()
                        HStack(alignment: .center, spacing: 8.0) {
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text("Holes Played:")
                                    .font(.title2.bold())
                                    .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                    .multilineTextAlignment(.leading)

                                Text("Average Putts:")
                                    .font(.title2.bold())
                                    .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                    .multilineTextAlignment(.leading)
                                
                                Text("Greens in Reg")
                                    .font(.title2.bold())
                                    .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                    .multilineTextAlignment(.leading)
                            }

                            Spacer().frame(minWidth: 0, minHeight: 0).layoutPriority(-1)

                            VStack(alignment: .leading, spacing: 8.0) {
                                Text("\(round.numHoles)")
                                    .font(.title2.bold())
                                    .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                    .multilineTextAlignment(.leading)

                                Text("\(Double(round.totalPutts) / Double(round.numHoles), specifier: "%.2f" )")
                                    .font(.title2.bold())
                                    .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                    .multilineTextAlignment(.leading)
                                
                                Text("\(round.greensInRegulation) / \(round.numHoles)")
                                    .font(.title2.bold())
                                    .foregroundColor(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0))
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .frame(width: 290.0, alignment: .center)
                    }
                    .frame(width: 320, height: 120)
                    //for rounded corners
                    .cornerRadius(10)


                    Divider()
                    ZStack {
                        Text("Scorecard")
                            .foregroundColor(Color.birdyColor)
                            .bold()
                            .font(.title)

                    }


                    GolfRoundView(golfRound: round, showLikeButton: false)
                        .padding()

                    HStack {

                        ForEach(0..<selectedImages.count, id: \.self) { i in
                              selectedImages[i]
                                  .resizable()
                                  .scaledToFit()
                                  .frame(width: 100, height: 100)
                          }
                    }
                    
                    PhotosPicker( selection: $selectedItems, maxSelectionCount: 3, matching: .images) {
                        HStack {
                            Text("Add Photos")
                            Image(systemName: "photo.on.rectangle.angled")
                        }
                    }
                    .onChange(of: selectedItems) { _ in
                        Task {
                            selectedImages.removeAll()
                            var imageDataArr = [Data]()

                            for item in selectedItems {
                                if let data = try? await item.loadTransferable(type: Data.self) {
                                    if let uiImage = UIImage(data: data) {
                                        imageDataArr.append(data)
                                        let image = Image(uiImage: uiImage)
                                        selectedImages.append(image)
                                    }
                                }
                            }
                            viewModel.uploadImages(imagesData: imageDataArr)
                        }
                    }

                    
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
}

//struct PostRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostRoundView()
//    }
//}
