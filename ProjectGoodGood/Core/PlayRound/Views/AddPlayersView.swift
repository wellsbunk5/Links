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
                .foregroundColor(Color.birdyColor)
                .bold()
                .font(.title)
            
            List {
                ForEach( viewModel.friends) { friend in
                    let added = players.contains(friend)
                    HStack {
                        Text("\(friend.fullname)")
                            .frame(height:45)
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
                    .foregroundColor(added ? Color.white : Color.black )
                    .background(added ? Color.parColor : .clear)
                }
                
            }
            
            Button {
                viewModel.updatePlayers(with: players)
                viewModel.playRoundPresentedViews.removeLast()
            } label: {
                Text("Done")
                    .foregroundColor(Color.parColor)
                    .font(.title2)
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
