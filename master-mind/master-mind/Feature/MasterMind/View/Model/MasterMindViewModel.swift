//
//  MasterMindViewModel.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import SwiftUI

@Observable
class MasterMindViewModel: MasterMindViewInterface {
    var feedback: [MasterMindFeedback] = []

    func update(state: [MasterMindFeedback]) {
        feedback = state
    }
}
