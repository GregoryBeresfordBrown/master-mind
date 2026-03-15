//
//  MasterMindViewModelTest.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import Testing
import SwiftUI
@testable import master_mind

@Suite("MasterMindViewModel")
@MainActor
struct MasterMindViewModelTest {
    @Test
    func viewModel_reset_hasEmptyState() throws {
        let model = MasterMindViewModel()

        model.reset(feedback: [.correctInWrongPosition, .noMatch, .correctInCorrectPosition])

        try #require(
            model.gameState == [
                MasterMindGuessState(guess: "-", color: .orange),
                MasterMindGuessState(guess: "-", color: .red),
                MasterMindGuessState(guess: "-", color: .green)
            ]
        )
    }

    @Test
    func viewModel_reset_destroyGuess() throws {
        let model = MasterMindViewModel()

        model.reset(feedback: [.correctInWrongPosition, .noMatch, .correctInCorrectPosition])

        model.gameState[0].guess = "A"

        model.reset(feedback: [.correctInWrongPosition, .noMatch, .correctInCorrectPosition])

        try #require(
            model.gameState == [
                MasterMindGuessState(guess: "-", color: .orange),
                MasterMindGuessState(guess: "-", color: .red),
                MasterMindGuessState(guess: "-", color: .green)
            ]
        )
    }

    @Test
    func viewModel_update_preservesGuess() throws {
        let model = MasterMindViewModel()

        model.reset(feedback: [.correctInWrongPosition, .noMatch, .correctInCorrectPosition])

        model.gameState[0].guess = "A"

        model.update(feedback: [.correctInWrongPosition, .noMatch, .correctInCorrectPosition])


        try #require(
            model.gameState == [
                MasterMindGuessState(guess: "A", color: .orange),
                MasterMindGuessState(guess: "-", color: .red),
                MasterMindGuessState(guess: "-", color: .green)
            ]
        )
    }
}
