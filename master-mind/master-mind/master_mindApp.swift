//
//  master_mindApp.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import SwiftUI

@main
struct master_mindApp: App {
    @State private var masterMind = MasterMind()

    var body: some Scene {
        WindowGroup {
            masterMind.makeView()
        }
    }
}
