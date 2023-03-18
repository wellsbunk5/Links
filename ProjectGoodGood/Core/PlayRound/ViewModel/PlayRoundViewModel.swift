//
//  UploadRoundViewModel.swift
//  ProjectGoodGood
//
//  Created by Wells Bunker on 1/20/23.
//

import Foundation
import Firebase
import SwiftUI

class PlayRoundViewModel: ObservableObject {
    @Published var playRoundPresentedViews: [String]
    @Binding var showPlayRoundModal: Bool
    var selectedCourse: Course
    let startingHole: Int
    let endingHole: Int
    var currentHole: Int
    var players: [User]
    var friends: [User]
    var tempGroup: TempGroup
    let roundType: RoundType
    
    let service = GolfRoundService()
    let userService = UserService()
    let courseService = GolfCourseService()
    
    init(startRoundViewModel: StartRoundViewModel, showPlayRoundModal: Binding<Bool>)  {
        if let joinGroup = startRoundViewModel.tempGroup {
            self.playRoundPresentedViews = [String]()
            self._showPlayRoundModal = showPlayRoundModal
            self.tempGroup = joinGroup
            self.startingHole = joinGroup.startingHole
            self.endingHole = joinGroup.endingHole
            self.currentHole = joinGroup.currentHole
            self.selectedCourse = joinGroup.course
            self.roundType = joinGroup.players.count > 1 ? RoundType.withFriends : RoundType.solo
            self.players = joinGroup.players
            self.friends = [User]()
            
            self.followTempGroupUpdates()
                        
            return
        }
        
        self._showPlayRoundModal = showPlayRoundModal
        self.tempGroup = InitalValues.tempGroup
        self.roundType = startRoundViewModel.roundType
        if let course = startRoundViewModel.selectedCourse {
            self.selectedCourse = course

        } else {
            self.selectedCourse = InitalValues.course
        }
        
        if startRoundViewModel.holesToPlay == Holes.front {
            self.startingHole = 1
            self.endingHole = 9
            
        } else if startRoundViewModel.holesToPlay == Holes.back {
            self.startingHole = 10
            self.endingHole = 18
        } else {
            self.startingHole = 1
            self.endingHole = 18
        }
        
        self.currentHole = startingHole
        
        self.players = [User]()
        self.friends = [User]()
        self.playRoundPresentedViews = [String]()
        self.tempGroup.numHoles = endingHole - startingHole + 1
        
        addActiveUserToPlayers()
        
        
        if startRoundViewModel.roundType == RoundType.withFriends {
//            self.playRoundPresentedViews.append("SelectPlayers")
            fetchFriends()
        }
        
        self.tempGroup.startingHole = self.startingHole
        self.tempGroup.endingHole = self.endingHole
        self.tempGroup.currentHole = self.startingHole
        self.tempGroup.course = self.selectedCourse
        if let courseId = self.selectedCourse.id {
            self.tempGroup.courseId = courseId
        }
        
    }
    
    func addActiveUserToPlayers() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        userService.fetchUser(withUid: uid) { user in
            self.players.append(user)
            self.tempGroup.players.append(user)
        }
    }
    

    
    func updatePlayers(with players: [User]) {
        self.players = players
        self.tempGroup.players = players
        
    }
    

    
    func fetchFriends() {
        userService.fetchFriends { friends in
            self.friends = friends
        }
    }
    
    func updateSoloScore(holeScores: HoleScore) {
        tempGroup.tempRounds[0].scores["\(currentHole)"] = holeScores.score
        tempGroup.tempRounds[0].putts["\(currentHole)"] = holeScores.putts
    }
    
    func nextHoleSoloRound(holeScores: HoleScore) {
        updateSoloScore(holeScores: holeScores)
        if currentHole < endingHole {
            currentHole += 1
            tempGroup.currentHole += 1
        }
    }
    func prevHoleSoloRound(holeScores: HoleScore) {
        updateSoloScore(holeScores: holeScores)
        if currentHole > startingHole {
            currentHole -= 1
            tempGroup.currentHole -= 1
        }
    }
    
    func updateGroupScores(holeScores: [HoleScore]) {
        for index in 0..<tempGroup.tempRounds.count {
            tempGroup.tempRounds[index].scores["\(currentHole)"] = holeScores[index].score
            tempGroup.tempRounds[index].putts["\(currentHole)"] = holeScores[index].putts
            
            tempGroup.tempRounds[index].totalScore = 0
            tempGroup.tempRounds[index].scores.values.forEach { score in
                tempGroup.tempRounds[index].totalScore += score
            }
        }
    }
    
    func nextHoleGroupRound(holeScores: [HoleScore]) {
        updateGroupScores(holeScores: holeScores)
        if currentHole < endingHole {
            currentHole += 1
            tempGroup.currentHole += 1
        }
        
        service.updateTempGroup(self.tempGroup)
        
    }
    
    func prevHoleGroupRound(holeScores: [HoleScore]) {
        updateGroupScores(holeScores: holeScores)
        if currentHole > startingHole {
            currentHole -= 1
            tempGroup.currentHole -= 1
        }
        service.updateTempGroup(self.tempGroup)
    }
    
    func populateTempRounds() {
        for player in players {
            let round = TempRound(userId: player.id ?? "guest", totalScore: 0, scores: ["\(startingHole)": 0], putts: ["\(startingHole)": 0], user: player)
            
            tempGroup.tempRounds.append(round)
        }
    }

    
    
    func postRound(_ round: GolfRound) {
        service.postRound(round)
        userService.updateUserStats(with: round)
        
        showPlayRoundModal = false
        
    }
    
    func postGroupRounds(_ rounds: [GolfRound]) {
        rounds.forEach { round in
            service.postRound(round)
            userService.updateUserStats(with: round)
        }
        
        showPlayRoundModal = false
    }
    
    func postTempGroup() {
        service.postTempGroup(tempGroup) { groupId in
            self.tempGroup.id = groupId
            self.followTempGroupUpdates()
            
        }
    }
    
    func followTempGroupUpdates() {
        if let groupId = tempGroup.id {
            service.followTempGroup(groupId) { updatedGroup in
                self.tempGroup = updatedGroup
                self.objectWillChange.send()
            }
        }
    }
    
    func generateSoloRound() -> GolfRound {
        var totalScore = 0
        var totalPutts = 0
        var greensInRegulation = 0
        var totalPar = 0
        var totalBogey = 0
        var totalEagle = 0
        var totalTriple = 0
        var totalDouble = 0
        var totalBirdie = 0
        
        for (key, score) in tempGroup.tempRounds[0].scores {
            let putts = tempGroup.tempRounds[0].putts["\(key)"] ?? 0
            
            let strokesToGreen = score - putts
            let holePar = selectedCourse.pars["\(key)"] ?? 4
            let greenInRegulationStrokes = holePar  - 2
            let strokesOverUnderPar = score - holePar
            
            totalPutts += putts
            totalScore += score
            
            if greenInRegulationStrokes >= strokesToGreen {
                greensInRegulation += 1
            }
            
            switch strokesOverUnderPar {
            case 1:
                totalBogey += 1
            case 2:
                totalDouble += 1
            case 3 ... 20:
                totalTriple += 1
            case -1:
                totalBirdie += 1
            case -4 ... -2 :
                totalEagle += 1
            default:
                totalPar += 1
            }
        }
        let tempRound = tempGroup.tempRounds[0]
        
        let round = GolfRound(userId: tempRound.userId, courseId: tempGroup.courseId, timestamp: tempGroup.timestamp, likes: 0, numHoles: tempGroup.numHoles, totalScore: totalScore, scores: tempRound.scores, putts: tempRound.putts, roundPictureUrls: tempGroup.roundPictureUrls, greensInRegulation: greensInRegulation, totalPutts: totalPutts, totalEagle: totalEagle, totalBirdie: totalBirdie, totalPar: totalPar, totalBogey: totalBogey, totalDouble: totalDouble, totalTriple: totalTriple, user: players[0])
        
        return round

    }
    
    func generateGroupRounds() -> [GolfRound] {
        var rounds = [GolfRound]()
        
        for index in 0..<tempGroup.tempRounds.count  {
            var totalScore = 0
            var totalPutts = 0
            var greensInRegulation = 0
            var totalPar = 0
            var totalBogey = 0
            var totalEagle = 0
            var totalTriple = 0
            var totalDouble = 0
            var totalBirdie = 0
            
            for (key, score) in tempGroup.tempRounds[index].scores {
                let putts = tempGroup.tempRounds[index].putts["\(key)"] ?? 0
                
                let strokesToGreen = score - putts
                let holePar = selectedCourse.pars["\(key)"] ?? 4
                let greenInRegulationStrokes = holePar  - 2
                let strokesOverUnderPar = score - holePar
                
                totalPutts += putts
                totalScore += score
                
                if greenInRegulationStrokes >= strokesToGreen {
                    greensInRegulation += 1
                }
        
                switch strokesOverUnderPar {
                case 1:
                    totalBogey += 1
                case 2:
                    totalDouble += 1
                case 3 ... 20:
                    totalTriple += 1
                case -1:
                    totalBirdie += 1
                case -4 ... -2 :
                    totalEagle += 1
                default:
                    totalPar += 1
                }
            }
            let tempRound = tempGroup.tempRounds[index]
            
            let round = GolfRound(userId: tempRound.userId, courseId: tempGroup.courseId, timestamp: tempGroup.timestamp, likes: 0, numHoles: tempGroup.numHoles, totalScore: totalScore, scores: tempRound.scores, putts: tempRound.putts, roundPictureUrls: tempGroup.roundPictureUrls, greensInRegulation: greensInRegulation, totalPutts: totalPutts, totalEagle: totalEagle, totalBirdie: totalBirdie, totalPar: totalPar, totalBogey: totalBogey, totalDouble: totalDouble, totalTriple: totalTriple, user: players[index])
            
            rounds.append(round)
            
            
        }
        
        return rounds
    }
    

    func navigationDestination(for path: String) -> AnyView {
        
        switch path {
        case "SelectPlayers":
            return AnyView ( AddPlayersView(viewModel: self, players: players))
        
        case "StartRound" :
            if roundType == RoundType.solo {
                return AnyView ( RecordScore(holeNum: "\(startingHole)", holeScores: HoleScore(score: 1, putts: 0), viewModel: self))
            }
            
            var holeScores = [HoleScore]()
            
            for _ in tempGroup.tempRounds {
                let scores = HoleScore(
                    score: 1,
                    putts: 0
                )
                
                holeScores.append(scores)
            }
            
            return AnyView ( GroupRecordScore(holeNum: "\(startingHole)", holeScores: holeScores, viewModel: self))
            

        
        case "NextHole" :
            if roundType == RoundType.solo {
                let holeScore = HoleScore(
                    score: tempGroup.tempRounds[0].scores["\(currentHole)"] ?? 1,
                    putts: tempGroup.tempRounds[0].putts["\(currentHole)"] ?? 0
                )
                return AnyView ( RecordScore(holeNum: "\(currentHole)", holeScores: holeScore, viewModel: self))

            }
            
            var holeScores = [HoleScore]()
            
            for round in tempGroup.tempRounds {
                let scores = HoleScore(
                    score: round.scores["\(currentHole)"] ?? 1,
                    putts: round.putts["\(currentHole)"] ?? 0
                )
                
                holeScores.append(scores)
            }
            
            return AnyView( GroupRecordScore(holeNum: "\(currentHole)", holeScores: holeScores, viewModel: self))
            
        case "FinishRound" :
            if roundType == RoundType.solo {
                let round = generateSoloRound()
                return AnyView( PostRoundView(viewModel: self, round: round))
            }
            
            let rounds = generateGroupRounds()
            
            return AnyView( GroupPostRoundView(viewModel: self, rounds: rounds))
            
        default :
            return AnyView (WaitingRoomView(viewModel: self))
            
        }
    }
    
    
}




struct InitalValues {
    static let course = Course(id: "fakeCourse", fullName: "Fake Course", nickname: "Fake Course", address: "Fake Course", city: "Fake Course", state: "Fake Course", zip: "Fake Course", totalPar: 76, pars: [
        "1": 4,
        "2": 4,
        "3": 5,
        "4": 4,
        "5": 3,
        "6": 3,
        "7": 5,
        "8": 4,
        "9":4
    ])
    
    static let tempGroup = TempGroup( courseId: "no id", timestamp: Timestamp(date: Date()), startingHole: 1, endingHole: 18, currentHole: 1, numHoles: 18, groupJoinCode: generateRandomJoinCode(), tempRounds: [TempRound](), players: [User](), course: InitalValues.course, roundPictureUrls: [String]())
    
    static func generateRandomJoinCode() -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<6).map{ _ in letters.randomElement()! })
    }
}
