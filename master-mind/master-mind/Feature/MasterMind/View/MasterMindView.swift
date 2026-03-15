//
//  MasterMindView.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import SwiftUI

protocol MasterMindViewPresenter {
    func viewDidAppear()
}

struct MasterMindView: View {
    let viewModel: MasterMindViewModel
    let presenter: MasterMindViewPresenter

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            presenter.viewDidAppear()
        }
    }
}
