struct ValueNodeWrapper<T>: ReflectionNodeWrapper {
    let node: ReflectionNode

    @MainActor var value: T {
        CastingUtils.memoryCast(node.object)
    }
}
