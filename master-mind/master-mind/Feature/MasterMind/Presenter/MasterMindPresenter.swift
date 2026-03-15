//
//  MasterMindPresenter.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import Foundation

protocol MasterMindViewInterface: AnyObject {
    @MainActor func reset(feedback: [MasterMindFeedback], deadline: Date)
    @MainActor func update(feedback: [MasterMindFeedback])
}

protocol MasterMindRouter {
    @MainActor func routeToSuccess(reset: @escaping () -> Void)
    @MainActor func routeToFailure(reset: @escaping () -> Void)
}

class MasterMindPresenter: MasterMindViewPresenter {
    private let gameInteractor: MasterMindGame
    private let view: MasterMindViewInterface
    private let router: MasterMindRouter

    init(
        gameInteractor: MasterMindGame,
        view: MasterMindViewInterface,
        router: MasterMindRouter
    ) {
        self.gameInteractor = gameInteractor
        self.view = view
        self.router = router
    }

    func viewDidAppear() {
        resetGame()
    }

    func didSubmitGuess(_ guess: String) {
        do {
            switch try gameInteractor.submit(guess: guess) {
            case .failed:
                router.routeToFailure { [weak self] in self?.resetGame() }

            case .success:
                router.routeToSuccess { [weak self] in self?.resetGame() }

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
            ),
            deadline: gameInteractor.timelimit
        )
    }
}
