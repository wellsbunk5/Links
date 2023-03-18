//
//  StartRoundView.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 3/14/23.
//

import SwiftUI

struct PlayRoundView: View {
    @ObservedObject var playRoundViewModel: PlayRoundViewModel
    @Binding var showPlayRoundModal: Bool
//    @Binding var showPlayRoundSheet: Bool
    
    
//    init(startRoundViewModel: StartRoundViewModel, showPlayRound: Binding<Bool>) {
//        self._showPlayRoundSheet = showPlayRound
//        self.playRoundViewModel = PlayRoundViewModel(startRoundViewModel: startRoundViewModel)
//    }
    
    init(startRoundViewModel: StartRoundViewModel, showPlayRoundModal: Binding<Bool>) {

        self.playRoundViewModel = PlayRoundViewModel(startRoundViewModel: startRoundViewModel, showPlayRoundModal: showPlayRoundModal)
        self._showPlayRoundModal = showPlayRoundModal
        
        if startRoundViewModel.tempGroup != nil {
            playRoundViewModel.playRoundPresentedViews.append("StartRound")
            
            for _ in playRoundViewModel.startingHole..<playRoundViewModel.currentHole {
                playRoundViewModel.playRoundPresentedViews.append("NextHole")
            }
        }
        

        
            
//            if playRoundViewModel.tempGroup.tempRounds.count > 0 {
//                playRoundViewModel.addPlayersFromIds()
//                playRoundViewModel.fetchCourse(by: playRoundViewModel.tempGroup.courseId)
//                playRoundViewModel.playRoundPresentedViews.append("StartRound")
                
    //            for _ in playRoundViewModel.startingHole..<playRoundViewModel.endingHole {
    //                playRoundViewModel.playRoundPresentedViews.append("NextHole")
    //            }
                
//                return
//        }

        

        
        
        
//        if playRoundViewModel.roundType == RoundType.solo {
//            playRoundViewModel.populateTempRounds()
//            playRoundViewModel.playRoundPresentedViews.append("StartRound")
//        }
//
//        if playRoundViewModel.roundType == RoundType.withFriends {
//            playRoundViewModel.playRoundPresentedViews.append("SelectPlayers")
//        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Cancel") {
                    showPlayRoundModal = false
                }
            }
            
            NavigationStack(path: $playRoundViewModel.playRoundPresentedViews) {
                WaitingRoomView(viewModel: playRoundViewModel)
            }
        }


    }
}

//struct PlayRoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayRoundView()
//    }
//}
