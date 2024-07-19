import SwiftUI

@MainActor public protocol LoadableProjectedValue {
    associatedtype T
    var projectedValue: Binding<T> { get }
    var loadable: Loadable { get }
}

@MainActor public extension LoadableProjectedValue {
    func loadAsync(_ asyncFunc: @MainActor () async throws -> T) async {
        await loadable.loadAsync {
            projectedValue.wrappedValue = try await asyncFunc()
        }
    }

    func loadSync(_ asyncFunc: @escaping @MainActor () async throws -> T) {
        loadable.loadSync {
            projectedValue.wrappedValue = try await asyncFunc()
        }
    }
}
