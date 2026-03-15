//
//  master_mindApp.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import SwiftUI

@main
struct master_mindApp: App {
    @State private var router = AppRouter()
    @State private var masterMind: MasterMind

    init() {
        let router = AppRouter()
        _router = State(initialValue: router)
        _masterMind = State(initialValue: MasterMind(router: router))
    }

    var body: some Scene {
        WindowGroup {
            switch router.routeState {
            case .game:    masterMind.makeView()
            case .success: Text("You won!")
            case .failure: Text("Game over!")
            }
        }
    }
}

@Observable
class AppRouter: MasterMindRouter {
    var routeState: RouteState = .game

    enum RouteState {
        case game, success, failure
    }

    func routeToSuccess() { routeState = .success }
    func routeToFailure() { routeState = .failure }
}
