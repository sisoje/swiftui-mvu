import SwiftUINative

struct TypeNodeReflection<T>: ReflectionNodeWrapper {
    let node: ReflectionNode

    var value: T {
        CastingUtils.memoryCast(node.object)
    }
}
