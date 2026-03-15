//
//  LetterPickerView.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 15/03/2026.
//

import SwiftUI

struct LetterPickerView: View {
    private let letters = Array("-0ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    @Binding var selectedLetter: Character

    var body: some View {
        Picker("Letter", selection: $selectedLetter) {
            ForEach(letters, id: \.self) { letter in
                Text(String(letter)).tag(letter)
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 80, height: 80)
        .clipped()
        .overlay {
            RoundedRectangle(cornerRadius: 6)
                .stroke(.primary, lineWidth: 3)
        }
    }
}

#Preview {
    @Previewable @State var selectedLetter: Character = "-"
    LetterPickerView(selectedLetter: $selectedLetter)
}
