//
//  LetterPickerView.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import SwiftUI

struct LetterPickerView: View {
    private let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    @State private var selectedIndex = 0
    @State private var isSpinning = false
    var onChange: (Character) -> Void = { _ in }

    var body: some View {
        VStack(spacing: 16) {
            Picker("Letter", selection: $selectedIndex) {
                ForEach(0..<letters.count, id: \.self) { i in
                    Text(String(letters[i])).tag(i)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 80, height: 80)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.primary, lineWidth: 3)
            }
            .onChange(of: selectedIndex) { _, newIndex in
                onChange(letters[newIndex])
            }
        }
    }
}

#Preview {
    LetterPickerView { _ in }
}
