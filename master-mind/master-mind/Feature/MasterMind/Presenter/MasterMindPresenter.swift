//
//  MasterMindPresenter.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

protocol MasterMindViewInterface: AnyObject {
    @MainActor func update(state: [MasterMindFeedback])
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
        view.update(
            state: gameInteractor.startNewGame(
                limit: 60
            )
        )
    }
}
