//
//  MasterMindViewModel.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import SwiftUI

@Observable
class MasterMindViewModel: MasterMindViewInterface {
    var gameState: [MasterMindGuessState] = []

    func reset(feedback: [MasterMindFeedback]) {
        gameState = feedback.map {
            MasterMindGuessState(
                guess: "-",
                feedback: $0
            )
        }
    }

    func update(feedback: [MasterMindFeedback]) {
        gameState = zip(gameState, feedback).map { gameState, feedback in
            MasterMindGuessState(
                guess: gameState.guess,
                feedback: feedback
            )
        }
    }
}

struct MasterMindGuessState: Equatable {
    var guess: Character
    let feedback: MasterMindFeedback
}
