//
//  MasterMindPresenter.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

protocol MasterMindViewInterface: AnyObject {
    @MainActor func reset(feedback: [MasterMindFeedback])
    @MainActor func update(feedback: [MasterMindFeedback])
}

class MasterMindPresenter: MasterMindViewPresenter {
    private let gameInteractor: MasterMindGame
    private let view: MasterMindViewInterface

    init(
        gameInteractor: MasterMindGame,
        view: MasterMindViewInterface
    ) {
        self.gameInteractor = gameInteractor
        self.view = view
    }

    func viewDidAppear() {
        resetGame()
    }

    func didSubmitGuess(_ guess: String) {
        do {
            switch try gameInteractor.submit(guess: guess) {
            case .failed:
                break; // Todo: navigate
            case .success:
                break; // Todo: navigate
            case .ongoing(let feedback):
                view.update(feedback: feedback)
            }

        }  catch {
            // Broken game, just reset it
            resetGame()
        }
    }

    private func resetGame() {
        view.reset(
            feedback: gameInteractor.startNewGame(
                limit: 60
            )
        )
    }
}
