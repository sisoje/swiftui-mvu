import SwiftUI

@propertyWrapper public struct LoadableState<T>: DynamicProperty, LoadableProjectedValue {
    @State public var wrappedValue: T
    @Loadable public var state
    public var projectedValue: Binding<T> { $wrappedValue.animation() }
    public var loadable: Loadable { _state }
    
    public init(wrappedValue value: T) {
        _wrappedValue = .init(wrappedValue: value)
    }
}
