import SwiftUI

extension View {   
    var reflectionSnapshot: TypeNodeReflection<Self> {
        TypeNodeReflection(node: ReflectionNode(object: self))
    }
}
