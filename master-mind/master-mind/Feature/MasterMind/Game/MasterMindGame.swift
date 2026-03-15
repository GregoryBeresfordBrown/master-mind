//
//  MasterMindGame.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import Foundation

protocol SecretGenerator {
    func generateSecret() -> Array<Character>
}

enum MasterMindFeedback: Equatable {
    case correctInWrongPosition
    case correctInCorrectPosition
    case noMatch
}

protocol GameClock {
    func now() -> Date
}

struct DefaultGameClock: GameClock {
    func now() -> Date { .now }
}

enum MasterMindGameError: Error {
    case badGuessLength, runOutOfTime
}

class MasterMindGame {
    private let secretGenerator: SecretGenerator
    private let gameClock: GameClock

    private var secret: [Character] = []
    private var timelimit: Date

    init(
        secretGenerator: SecretGenerator,
        gameClock: GameClock = DefaultGameClock()
    ) {
        self.secretGenerator = secretGenerator
        self.gameClock = gameClock
        self.secret = []
        self.timelimit = gameClock.now() - 1.0
    }

    func startNewGame(limit: TimeInterval) -> [MasterMindFeedback] {
        secret = secretGenerator.generateSecret()
        timelimit = gameClock.now() + limit
        print("+++ New Game", String(secret))
        print("+++ Time", gameClock.now(), "to", timelimit)

        return (0..<secret.count).map { _ in .noMatch }
    }

    func submit(guess: String) throws(MasterMindGameError) -> [MasterMindFeedback] {
        guard guess.count == secret.count else {
            throw .badGuessLength
        }
        guard gameClock.now() <= timelimit else {
            throw .runOutOfTime
        }

        let guess = Array(guess.uppercased())

        return (0..<secret.count).map { (i:Int) -> MasterMindFeedback in
            secret[i] == guess[i]
                ? .correctInCorrectPosition
                : secretContains(char: guess[i])
        }
    }

    private func secretContains(char: Character) -> MasterMindFeedback {
        for j in 0..<secret.count {
            if secret[j] == char {
                return .correctInWrongPosition
            }
        }
        return .noMatch
    }
}
