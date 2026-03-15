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
    var currentGuess: String {
        String(gameState.map(\.guess))
    }

    func reset(feedback: [MasterMindFeedback]) {
        gameState = feedback.map {
            MasterMindGuessState(
                guess: "-",
                color: $0.color
            )
        }
    }

    func update(feedback: [MasterMindFeedback]) {
        gameState = zip(gameState, feedback).map { gameState, feedback in
            MasterMindGuessState(
                guess: gameState.guess,
                color: feedback.color
            )
        }
    }
}

private extension MasterMindFeedback {
    var color: Color {
        switch self {
        case .correctInCorrectPosition: .green
        case .correctInWrongPosition:   .orange
        case .noMatch:                  .red
        }
    }
}

@Observable
class MasterMindGuessState: Equatable, Hashable {
    var guess: Character
    let color: Color

    init(guess: Character, color: Color) {
        self.guess = guess
        self.color = color
    }

    static func == (lhs: MasterMindGuessState, rhs: MasterMindGuessState) -> Bool {
        lhs.guess == rhs.guess && lhs.color == rhs.color
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(guess)
        hasher.combine(color)
    }
}
