struct DynamicNodeWrapper<BASE>: ReflectionNodeWrapper {
    let node: ReflectionNode

    static var baseTypeinfo: TypeInfo {
        TypeInfo(BASE.self)
    }
    
    var baseTypeinfo: TypeInfo {
        Self.baseTypeinfo
    }

    func cast<T>(_ t: T.Type = T.self) -> T? {
        node.object as? T
    }

    func forceCast<T>(_ t: T.Type = T.self) -> T {
        CastingUtils.memoryCast(node.object, T.self)
    }
}



