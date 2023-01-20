//
//  PlayRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/17/23.
//

import SwiftUI

struct PlayRoundView: View {
    @ObservedObject var viewModel = UploadRoundViewModel()
    
    var body: some View {
        Button {
            viewModel.uploadRound()
        } label: {
            Text("Play Round")
                .bold()
                .padding()
                .background(Color(.blue))
                .foregroundColor(.white)
                .clipShape(Capsule())
            
        }
    }
}

struct PlayRoundView_Previews: PreviewProvider {
    static var previews: some View {
        PlayRoundView()
    }
}
