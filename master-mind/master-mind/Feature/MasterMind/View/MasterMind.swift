//
//  MasterMind.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import SwiftUI

class MasterMind {
    private let game = MasterMindGame()
    private let view = MasterMindViewModel()

    init() {}

    func makeView() -> some View {
        MasterMindView(
            viewModel: view,
            presenter: MasterMindPresenter(
                gameInteractor: game,
                view: view
            )
        )
    }
}

#Preview {
    MasterMind().makeView()
}
