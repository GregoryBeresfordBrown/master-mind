//
//  Notification.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 16/03/2026.
//

import SwiftUI

class Notification: Identifiable {
    let id = UUID()
    private let label: String
    private var continuation: CheckedContinuation<Void, Never>?

    init(label: String) {
        self.label = label
    }

    var completion: Void {
        get async {
            await withCheckedContinuation { self.continuation = $0 }
        }
    }

    private func complete() {
        continuation?.resume()
        continuation = nil
    }

    func makeView() -> some View {
        NotificationView(
            label: label,
            presenter: NotificationPresenter { [weak self] in
                self?.complete()
            }
        )
    }
}
