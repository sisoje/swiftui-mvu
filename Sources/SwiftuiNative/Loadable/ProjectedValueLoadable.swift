import SwiftUI

@propertyWrapper public struct LoadableValue<T>: DynamicProperty {
    @State public var wrappedValue: T
    @Loadable public var state
    public var projectedValue: Binding<T> { $wrappedValue.animation() }
    public var loadable: Loadable { _state }
    
    public init(wrappedValue value: T) {
        _wrappedValue = .init(wrappedValue: value)
    }
}

@propertyWrapper public struct LoadableBinding<T>: DynamicProperty {
    @Binding public var wrappedValue: T
    @Loadable public var state
    public var projectedValue: Binding<T> { $wrappedValue.animation() }
    public var loadable: Loadable { _state }
    
    public init(_ binding: Binding<T>) {
        _wrappedValue = binding
    }
}

extension LoadableValue: ProjectedValueLoadable {}
extension LoadableBinding: ProjectedValueLoadable {}

@MainActor public protocol ProjectedValueLoadable {
    associatedtype T
    var projectedValue: Binding<T> { get }
    var loadable: Loadable { get }
}

@MainActor public extension ProjectedValueLoadable {
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
