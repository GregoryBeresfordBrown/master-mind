//
//  MasterMindPresenter.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

protocol MasterMindViewInterface: AnyObject {}

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
}
