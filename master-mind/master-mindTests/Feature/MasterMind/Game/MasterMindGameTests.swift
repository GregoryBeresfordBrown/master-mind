//
//  MasterMindGame.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import Testing
@testable import master_mind

@Suite("MasterMindGame")
@MainActor
struct MasterMindGameTests {
    let generation = FixedSecret()

    @Test func startNewGame_returnsMatchingInitialState() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let state = game.startNewGame()

        try #require(state.count == generation.secret.count)
        try #require(state.allSatisfy { $0 == MasterMindFeedback.noMatch } )
    }

    @Test func submitGuess_withNoMatches_returnsFeedbackWithNoMatches() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame()
        let state = game.submit(guess: "EFGH")

        try #require(state.count == generation.secret.count)
        try #require(state.allSatisfy { $0 == .noMatch } )
    }

    @Test func submitGuess_withCorrectMatch_returnsCorrectFeedback() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame()
        let state = game.submit(guess: "ABCD")

        try #require(state.count == generation.secret.count)
        try #require(state.allSatisfy { $0 == .correctInCorrectPosition } )
    }

    @Test func submitGuess_withIncorrectMatches_returnsPositionFeedback() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame()
        let state = game.submit(guess: "BCEF")

        try #require(state.count == generation.secret.count)
        try #require(
            state == [
                .correctInWrongPosition,
                .correctInWrongPosition,
                .noMatch,
                .noMatch
            ]
        )
    }
}


struct FixedSecret: SecretGenerator {
    var secret: String = "ABCD"

    func generateSecret() -> Array<Character> {
        Array(secret)
    }
}
