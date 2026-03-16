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
            masterMind.makeView()
                .sheet(item: Binding(get: { router.notification }, set: { router.notification = $0 })) { notification in
                    notification.makeView()
                }
        }
    }
}

@Observable
class AppRouter: MasterMindRouter {
    var notification: Notification?

    func routeToSuccess() async {
        let notification = Notification(label: "You won!")
        self.notification = notification
        await notification.completion
        self.notification = nil
    }

    func routeToFailure() async {
        let notification = Notification(label: "Game over!")
        self.notification = notification
        await notification.completion
        self.notification = nil
    }
}
