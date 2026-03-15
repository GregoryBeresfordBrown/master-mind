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

            TimelineView(.periodic(from: .now, by: 0.1)) { _ in
                if let remainingTime = viewModel.remainingTime {
                    Text(remainingTime, format: .number.precision(.fractionLength(1)))
                        .font(.monospacedDigit(.title)())
                        .foregroundStyle(remainingTime < 10.0 ? .red : .primary)
                        .onChange(of: remainingTime) { _, time in
                            if time.isZero {
                                presenter.didSubmitGuess(viewModel.currentGuess)
                            }
                        }
                }
            }

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
