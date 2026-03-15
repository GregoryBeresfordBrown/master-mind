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

@Observable
class MasterMindGuessState: Equatable, Hashable {
    var guess: Character
    let feedback: MasterMindFeedback

    init(guess: Character, feedback: MasterMindFeedback) {
        self.guess = guess
        self.feedback = feedback
    }

    static func == (lhs: MasterMindGuessState, rhs: MasterMindGuessState) -> Bool {
        lhs.guess == rhs.guess && lhs.feedback == rhs.feedback
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(guess)
        hasher.combine(feedback)
    }
}
