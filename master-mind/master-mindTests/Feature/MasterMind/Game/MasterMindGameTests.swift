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

        try #require(state.count == generation.secret.count)
        try #require(state.allSatisfy { $0 == .noMatch } )
    }

    @Test func submitGuess_withCorrectMatch_returnsCorrectFeedback() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame(limit: 10)
        let state = try game.submit(guess: "ABCD")

        try #require(state.allSatisfy { $0 == .correctInCorrectPosition } )
    }

    @Test func submitGuess_withIncorrectMatches_returnsPositionFeedback() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame(limit: 10)
        let state = try game.submit(guess: "BCEF")

        try #require(
            state == [
                .correctInWrongPosition,
                .correctInWrongPosition,
                .noMatch,
                .noMatch
            ]
        )
    }

    @Test func submitGuess_withAllIncorrectMatches_returnsPositionFeedback() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame(limit: 10)
        let state = try game.submit(guess: "CDAB")

        try #require(state.allSatisfy { $0 == .correctInWrongPosition } )
    }

    @Test func submitGuess_withLengthMismatch_throwsBadGuessFormat() throws {
        let game = MasterMindGame(secretGenerator: generation)
        let _ = game.startNewGame(limit: 10)

        #expect(throws: MasterMindGameError.badGuessLength) {
            try game.submit(guess: "CD")
        }
    }

    @Test func submitGuess_withoutGameStart_throwsError() throws {
        let clock = FixedClock()
        let game = MasterMindGame(secretGenerator: generation, gameClock: clock)

        #expect(throws: MasterMindGameError.runOutOfTime) {
            try game.submit(guess: "")
        }
    }

    @Test func submitGuess_afterExpiry_throwsError() throws {
        let clock = FixedClock()
        let game = MasterMindGame(secretGenerator: generation, gameClock: clock)
        let _ = game.startNewGame(limit: 10)

        #expect(throws: Never.self) {
            try game.submit(guess: "ABCD")
        }

        clock.startTime = clock.startTime + 10.1

        #expect(throws: MasterMindGameError.runOutOfTime) {
            try game.submit(guess: "ABCD")
        }
    }

    @Test func startNewGame_resetsExpiry_guessSucceeds() throws {
        let clock = FixedClock()
        let game = MasterMindGame(secretGenerator: generation, gameClock: clock)
        let _ = game.startNewGame(limit: 10)

        clock.startTime = clock.startTime + 10.1

        #expect(throws: MasterMindGameError.runOutOfTime) {
            try game.submit(guess: "ABCD")
        }

        let _ = game.startNewGame(limit: 10)

        #expect(throws: Never.self) {
            try game.submit(guess: "ABCD")
        }
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

