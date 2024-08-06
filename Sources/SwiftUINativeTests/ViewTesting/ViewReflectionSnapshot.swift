import SwiftUI

extension View {   
    var reflectionSnapshot: ValueNodeWrapper<Self> {
        ValueNodeWrapper(node: ReflectionNode(object: self))
    }
}
