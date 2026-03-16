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
            AppView(router: router, masterMind: masterMind)
        }
    }
}

struct AppView: View {
    @Bindable var router: AppRouter
    let masterMind: MasterMind

    var body: some View {
        masterMind.makeView()
            .sheet(item: $router.notification) { notification in
                notification.makeView()
            }
    }
}

@Observable
class AppRouter: MasterMindRouter {
    var notification: GameNotification?

    func routeToSuccess() async {
        let notification = GameNotification(label: "You won!")
        self.notification = notification
        await notification.completion
        self.notification = nil
    }

    func routeToFailure() async {
        let notification = GameNotification(label: "Game over!")
        self.notification = notification
        await notification.completion
        self.notification = nil
    }
}

#Preview {
    let router = AppRouter()
    AppView(router: router, masterMind: MasterMind(router: router))
}
