//
//  NotificationView.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 16/03/2026.
//

import SwiftUI

struct NotificationView: View {
    let label: String
    let presenter: NotificationViewPresenter

    var body: some View {
        VStack {
            Text(label)
                .font(.largeTitle)
                .padding()

            Button {
                presenter.didTapRetry()
            } label: {
                Text("Retry")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
        .interactiveDismissDisabled()
    }
}
