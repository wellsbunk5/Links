//
//  AddPlayersView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 3/14/23.
//

import SwiftUI

struct AddPlayersView: View {
    var viewModel: PlayRoundViewModel
    @State var players: [User]
    
    var body: some View {
        VStack {
            Text("Add Players")
            
            List {
                ForEach( viewModel.friends) { friend in
                    let added = players.contains(friend)
                    HStack {
                        Text("\(friend.fullname)")
                        Spacer()
                        if added != true {
                            Button {
                                players.append(friend)
                            } label: {
                                Image(systemName: "person.badge.plus")
                            }
                        } else {
                            Button {
                                if let index = players.firstIndex(of: friend) {
                                    players.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "person.badge.minus")
                            }
                        }

                    }
                    .background(added ? Color.birdyColor : Color.lightGreyColor)
                }
                
            }
            
            Button {
                viewModel.updatePlayers(with: players)
                viewModel.playRoundPresentedViews.removeLast()
            } label: {
                Text("Done")
            }
        }
        .toolbar(.hidden)

    }
}

//struct AddPlayersView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPlayersView()
//    }
//}
