//
//  StartGroupView.swift
//  ProjectGoodGood
//
//  Created by Bri Rhineer on 3/13/23.
//

import SwiftUI
import PhotosUI

struct GroupPostRoundView: View {
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    var viewModel: PlayRoundViewModel
    var rounds: [GolfRound]
    var body: some View {
        VStack {
            ScrollView {
                VStack{
                    ZStack {
                        Text("Scorecard")
                            .foregroundColor(Color.birdyColor)
                            .bold()
                            .font(.title)
                    }
                    ForEach(rounds, id: \.userId) { round in
                        GolfRoundView(golfRound: round, showLikeButton: false)
                            .padding()
                    }
                }
            }
            
            HStack {

                ForEach(0..<selectedImages.count, id: \.self) { i in
                      selectedImages[i]
                          .resizable()
                          .scaledToFit()
                          .frame(width: 100, height: 100)
                  }
            }
            
            PhotosPicker( selection: $selectedItems, maxSelectionCount: 3, matching: .images) {
                ZStack{
                    Color.doubleBogeyColor
                        .ignoresSafeArea()
                    HStack {
                        Text("Add Photos")
                        Image(systemName: "photo.on.rectangle.angled")
                    }
                }
                .frame(width: 250, height:40)
                .cornerRadius(10)
                .foregroundColor(Color.white)
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
                            viewModel.postGroupRounds(rounds)
                        } label: {
                            Text("Post Round")
                                .foregroundColor(Color.white)
                                .frame(width: 213.3, height:60)
                        }
                        //.frame(width: 213.3, height:60)
                    }
                }
                .frame(width: 213.3, height:60)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }
        }
        .toolbar(.hidden)
    }
}

//struct GroupPostRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupPostRoundView()
//    }
//}
