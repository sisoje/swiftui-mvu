import SwiftUI

extension Binding {
    @MainActor static func variable<T>(_ initial: T) -> Binding<T> {
        var temp = initial
        return Binding<T> {
            temp
        } set: {
            temp = $0
        }
    }
}
