import SwiftUI

@MainActor extension View {   
    var reflectionSnapshot: ValueNodeWrapper<Self> {
        ValueNodeWrapper(node: ReflectionNode(object: self))
    }
}
