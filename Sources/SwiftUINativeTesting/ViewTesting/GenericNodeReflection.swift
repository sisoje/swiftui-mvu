import SwiftUINative

struct GenericNodeReflection<BASE>: ReflectionNodeWrapper {
    let node: ReflectionNode

    static var basetype: String {
        TypeInfo(BASE.self).baseTypename
    }
    
    var basetype: String {
        Self.basetype
    }

    func cast<T>(_ t: T.Type = T.self) -> T? {
        node.object as? T
    }

    func forceCast<T>(_ t: T.Type = T.self) -> T {
        CastingUtils.memoryCast(node.object, T.self)
    }
}



