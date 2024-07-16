import SwiftUI

extension Notification.Name {
    static let bodyEvaluationNotification = Notification.Name("bodyEvaluationNotification")
}

public extension View {
    func postBodyEvaluationNotification() {
        assert({
            Self._printChanges()
            NotificationCenter.default.post(name: .bodyEvaluationNotification, object: self)
        }() == ())
    }
}
