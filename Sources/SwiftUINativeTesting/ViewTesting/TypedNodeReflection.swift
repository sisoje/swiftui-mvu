import SwiftUINative

struct TypedNodeReflection<T>: ReflectionNodeWrapper {
    let node: ReflectionNode

    var value: T {
        CastingUtils.memoryCast(node.object)
    }
}
