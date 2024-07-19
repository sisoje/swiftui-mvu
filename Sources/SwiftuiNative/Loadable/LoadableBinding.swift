import SwiftUI

@propertyWrapper public struct LoadableBinding<T>: DynamicProperty, LoadableProjectedValue {
    @Binding public var wrappedValue: T
    @Loadable public var state
    public var projectedValue: Binding<T> { $wrappedValue.animation() }
    public var loadable: Loadable { _state }
    
    public init(_ binding: Binding<T>) {
        _wrappedValue = binding
    }
}
