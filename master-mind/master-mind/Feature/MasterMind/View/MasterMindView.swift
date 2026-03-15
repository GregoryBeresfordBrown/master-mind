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
            Text("Take a guess!")
                .font(.largeTitle)

            HStack {
                LetterPickerView { letter in
                    print("+++", letter)
                }
            }
        }
        .padding()
        .onAppear {
            presenter.viewDidAppear()
        }
    }
}
