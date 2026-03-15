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

struct DefaultSecretGenerator: SecretGenerator {
    private let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    func generateSecret() -> Array<Character> {
        (0..<4).compactMap { _ in letters.randomElement() }
    }
}

enum MasterMindGameState: Equatable {
    case success
    case failed
    case ongoing([MasterMindFeedback])
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
    case badGuessLength
}

class MasterMindGame {
    private let secretGenerator: SecretGenerator
    private let gameClock: GameClock

    private var secret: [Character] = []
    private(set) var timelimit: Date

    init(
        secretGenerator: SecretGenerator = DefaultSecretGenerator(),
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

    func submit(guess: String) throws(MasterMindGameError) -> MasterMindGameState {
        guard guess.count == secret.count else {
            throw .badGuessLength
        }
        guard gameClock.now() <= timelimit else {
            return .failed
        }

        let guess = Array(guess.uppercased())

        let result = (0..<secret.count).map { (i:Int) -> MasterMindFeedback in
            secret[i] == guess[i]
                ? .correctInCorrectPosition
                : secretContains(char: guess[i])
        }

        return result.allSatisfy { $0 == .correctInCorrectPosition }
            ? .success
            : .ongoing(result)
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
