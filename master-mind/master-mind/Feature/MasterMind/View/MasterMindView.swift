//
//  MasterMindView.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import SwiftUI

protocol MasterMindViewPresenter {
    func viewDidAppear()
    func didSubmitGuess(_ guess: String)
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
                    LetterPickerView(
                        selectedLetter: $viewModel.gameState[i].guess,
                        color: viewModel.gameState[i].color
                    )
                }
            }

            Button {
                presenter.didSubmitGuess(viewModel.currentGuess)
            } label: {
                Text("Submit")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
        .padding()
        .onAppear {
            presenter.viewDidAppear()
        }
    }
}
