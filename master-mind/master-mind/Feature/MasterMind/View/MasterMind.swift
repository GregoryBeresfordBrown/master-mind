//
//  MasterMind.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import SwiftUI

class MasterMind {
    private let router: MasterMindRouter
    private let game = MasterMindGame()
    private let view = MasterMindViewModel()

    init(router: MasterMindRouter) {
        self.router = router
    }

    func makeView() -> some View {
        MasterMindView(
            viewModel: view,
            presenter: MasterMindPresenter(
                gameInteractor: game,
                view: view,
                router: router
            )
        )
    }
}

#Preview {
    struct MockRouter: MasterMindRouter {
        func routeToSuccess() {}
        func routeToFailure() {}
    }
    return MasterMind(router: MockRouter()).makeView()
}
