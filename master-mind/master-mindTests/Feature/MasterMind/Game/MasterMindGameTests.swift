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
}


struct FixedSecret: SecretGenerator {
    var secret: String = "ABCD"

    func generateSecret() -> String {
        secret
    }
}
