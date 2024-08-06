import SwiftUI

extension View {   
    var reflectionSnapshot: TypedNodeReflection<Self> {
        TypedNodeReflection(node: ReflectionNode(object: self))
    }
}
