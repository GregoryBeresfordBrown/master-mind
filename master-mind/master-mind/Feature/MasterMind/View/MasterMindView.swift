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
    @Bindable
    var viewModel: MasterMindViewModel
    let presenter: MasterMindViewPresenter

    var body: some View {
        VStack {
            Text("Take a guess!")
                .font(.largeTitle)

            HStack {
                ForEach(viewModel.gameState.indices, id: \.self) { i in
                    LetterPickerView(selectedLetter: $viewModel.gameState[i].guess)
                }
            }
        }
        .padding()
        .onAppear {
            presenter.viewDidAppear()
        }
    }
}
