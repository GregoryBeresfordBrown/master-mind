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
            case .success: notification("You won!")
            case .failure: notification("Game over!")
            }
        }
    }

    func notification(_ label: String) -> some View {
        VStack {
            Text(label)
                .font(.largeTitle)
                .padding()

            Button {
                router.reset()
            } label: {
                Text("Retry")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
    }
}

@Observable
class AppRouter: MasterMindRouter {
    // I took a shortcut here due to time constraints

    var routeState: RouteState = .game
    var reset: () -> Void = { }

    enum RouteState {
        case game, success, failure
    }

    func routeToSuccess(reset: @escaping () -> Void) {
        routeState = .success
        self.reset = { [weak self] in
            reset()
            self?.routeState = .game
        }
    }

    func routeToFailure(reset: @escaping () -> Void) {
        routeState = .failure
        self.reset = { [weak self] in
            reset()
            self?.routeState = .game
        }
    }
}
