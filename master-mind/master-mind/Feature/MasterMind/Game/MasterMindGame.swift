//
//  MasterMindGame.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

protocol SecretGenerator {
    func generateSecret() -> String
}

enum MasterMindFeedback: Equatable {
    case correctInWrongPosition
    case correctInCorrectPosition
    case noMatch
}

class MasterMindGame {
    private let secretGenerator: SecretGenerator
    private var secret: String

    init(secretGenerator: SecretGenerator) {
        self.secretGenerator = secretGenerator
        self.secret = ""
    }

    func startNewGame() -> [MasterMindFeedback] {
        secret = secretGenerator.generateSecret()
        print("+++ New Game", secret)

        return (0..<secret.count).map { _ in .noMatch }
    }
}
