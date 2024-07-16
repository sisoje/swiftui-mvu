//
//  SwiftUITestingSupport.swift
//  Part2Tests
//
//  Created by Lazar on 04/06/2024.
//

import SwiftUI
@testable import SwiftuiNative

extension Notification: @unchecked Sendable {
    // this silences the "notification is not sendable" warning
}

extension View {
    @MainActor static func getTestView(timeout: TimeInterval = 1) async throws -> Self {
        // normally we get notification immediately but if there is any problem we dont want to wait forever
        let timeoutTask = Task {
            try await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
            // if timeout happens we post nil to unblock the await
            NotificationCenter.default.post(name: .bodyEvaluationNotification, object: nil)
        }
        defer { timeoutTask.cancel() }
        for await n in NotificationCenter.default.notifications(named: .bodyEvaluationNotification) {
            guard let v = n.object else {
                throw NSError(domain: "Add 'let _ = postBodyEvaluationNotification()' and refer to the state inside the body", code: 0)
            }
            guard let v = v as? Self else {
                continue
            }
            return v
        }
        fatalError()
    }
}
