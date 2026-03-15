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
    var deadline: Date?
    var currentGuess: String {
        String(gameState.map(\.guess))
    }
    var remainingTime: TimeInterval? {
        guard let deadline else { return nil }
        return max(0, deadline.timeIntervalSince(.now))
    }

    func reset(
        feedback: [MasterMindFeedback],
        deadline: Date
    ) {
        gameState = feedback.map {
            MasterMindGuessState(
                guess: "-",
                color: $0.color
            )
        }
        self.deadline = deadline
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
