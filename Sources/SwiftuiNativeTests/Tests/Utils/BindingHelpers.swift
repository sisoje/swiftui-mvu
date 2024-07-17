import SwiftUI

extension Binding {
    static func variable<T>(_ initial: T) -> Binding<T> {
        var temp = initial
        return Binding<T> {
            temp
        } set: {
            temp = $0
        }
    }
}
