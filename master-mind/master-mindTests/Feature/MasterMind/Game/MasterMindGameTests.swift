//
//  MasterMindGame.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import Foundation
import Testing
@testable import master_mind

@Suite("MasterMindGame")
@MainActor
struct MasterMindGameTests {
    let generation = FixedSecret()

    @Test func startNewGame_returnsMatchingInitialState() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let state = game.startNewGame(limit: 10)

        try #require(state.count == generation.secret.count)
        try #require(state.allSatisfy { $0 == MasterMindFeedback.noMatch } )
    }

    @Test func submitGuess_withNoMatches_returnsFeedbackWithNoMatches() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame(limit: 10)
        let state = try game.submit(guess: "EFGH")

        try #require(
            state == .ongoing([
                .noMatch, .noMatch, .noMatch, .noMatch
            ])
        )
    }

    @Test func submitGuess_withCorrectMatch_returnsCorrectFeedback() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame(limit: 10)
        let state = try game.submit(guess: "ABCD")

        try #require(state == .success)
    }

    @Test func submitGuess_withIncorrectMatches_returnsPositionFeedback() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame(limit: 10)
        let state = try game.submit(guess: "BCEF")

        try #require(
            state == .ongoing([
                .correctInWrongPosition,
                .correctInWrongPosition,
                .noMatch,
                .noMatch
            ])
        )
    }

    @Test func submitGuess_withAllIncorrectMatches_returnsPositionFeedback() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame(limit: 10)
        let state = try game.submit(guess: "CDAB")

        try #require(
            state == .ongoing([
                .correctInWrongPosition,
                .correctInWrongPosition,
                .correctInWrongPosition,
                .correctInWrongPosition
            ])
        )
    }

    @Test func submitGuess_withLengthMismatch_throwsBadGuessFormat() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame(limit: 10)

        #expect(throws: MasterMindGameError.badGuessLength) {
            try game.submit(guess: "CD")
        }
    }

    @Test func submitGuess_withoutGameStart_isFailed() throws {
        let clock = FixedClock()
        let game = MasterMindGame(secretGenerator: generation, gameClock: clock)

        let state = try game.submit(guess: "")

        try #require(state == .failed)
    }

    @Test func submitGuess_afterExpiry_isFailed() throws {
        let clock = FixedClock()
        let game = MasterMindGame(secretGenerator: generation, gameClock: clock)
        let _ = game.startNewGame(limit: 10)

        clock.startTime = clock.startTime + 10.1

        let state = try game.submit(guess: "ABCD")

        try #require(state == .failed)
    }

    @Test func startNewGame_resetsExpiry_guessSucceeds() throws {
        let clock = FixedClock()
        let game = MasterMindGame(secretGenerator: generation, gameClock: clock)
        let _ = game.startNewGame(limit: 10)

        clock.startTime = clock.startTime + 10.1

        try #require(game.submit(guess: "ABCD") == .failed)

        let _ = game.startNewGame(limit: 10)

        try #require(
            game.submit(guess: "DCBA") == .ongoing([
                .correctInWrongPosition,
                .correctInWrongPosition,
                .correctInWrongPosition,
                .correctInWrongPosition
            ])
        )
    }
}

struct FixedSecret: SecretGenerator {
    var secret: String = "ABCD"

    func generateSecret() -> Array<Character> {
        Array(secret)
    }
}

class FixedClock: GameClock {
    var startTime: Date = .now

    func now() -> Date {
        startTime
    }
}

