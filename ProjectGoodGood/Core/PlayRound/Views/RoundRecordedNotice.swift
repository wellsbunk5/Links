//
//  RoundRecordedNotice.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 3/28/23.
//

import SwiftUI

struct RoundRecordedNotice: View {
    var viewModel: PlayRoundViewModel
    var body: some View {
        VStack {
            Text("This Round Has Been Posted By Another Player")
            ZStack {
                Color.darkGreyColor
                    .ignoresSafeArea()
                Button {
                    viewModel.showPlayRoundModal = false
                } label: {
                    Text("Exit")
                        .frame(width: 106.7, height:60)
                }
            }
            .frame(width: 106.7, height:60)
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
        .toolbar(.hidden)
        
    }
}

//struct RoundRecordedNotice_Previews: PreviewProvider {
//    static var previews: some View {
//        RoundRecordedNotice()
//    }
//}
