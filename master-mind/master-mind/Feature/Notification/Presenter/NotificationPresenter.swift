//
//  NotificationPresenter.swift
//  master-mind
//
//  Created by Gregory Beresford Brown on 16/03/2026.
//

import Foundation

protocol NotificationViewPresenter {
    func didTapRetry()
}

class NotificationPresenter: NotificationViewPresenter {
    private let completion: () -> Void

    init(completion: @escaping () -> Void) {
        self.completion = completion
    }

    func didTapRetry() {
        completion()
    }
}
