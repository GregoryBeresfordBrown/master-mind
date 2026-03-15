//
//  MasterMindGame.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

protocol SecretGenerator {
    func generateSecret() -> Array<Character>
}

enum MasterMindFeedback: Equatable {
    case correctInWrongPosition
    case correctInCorrectPosition
    case noMatch
}

class MasterMindGame {
    private let secretGenerator: SecretGenerator
    private var secret: [Character] = []

    init(secretGenerator: SecretGenerator) {
        self.secretGenerator = secretGenerator
        self.secret = []
    }

    func startNewGame() -> [MasterMindFeedback] {
        secret = secretGenerator.generateSecret()
        print("+++ New Game", String(secret))

        return (0..<secret.count).map { _ in .noMatch }
    }

    func submit(guess: String) -> [MasterMindFeedback] {
        let guess = Array(guess.uppercased())

        return (0..<secret.count).map { (i:Int) -> MasterMindFeedback in
            secret[i] == guess[i]
                ? .correctInCorrectPosition
                : .noMatch
        }
    }
}
