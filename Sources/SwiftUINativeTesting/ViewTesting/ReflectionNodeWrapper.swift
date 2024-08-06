protocol ReflectionNodeWrapper {
    var node: ReflectionNode { get }
}

extension ReflectionNodeWrapper {
    func genericTypeNodes<T>() -> [GenericNodeReflection<T>] {
        let baseTypename = TypeInfo(T.self).baseTypename
        return node.allNodes.filter { $0.typeInfo.baseTypename == baseTypename }.map(GenericNodeReflection<T>.init)
    }

    func valueNodes<T>(_ t: T.Type = T.self) -> [TypedNodeReflection<T>] {
        node.allNodes.filter { $0.object is T }.map(TypedNodeReflection.init)
    }

    var asyncActions: [TypedNodeReflection<() async -> Void>] {
        let basetype = TypeInfo((() async -> Void).self).baseTypename
        return node.allNodes.filter { $0.typeInfo.typename.hasSuffix(basetype) }.map(TypedNodeReflection.init)
    }

    var actions: [TypedNodeReflection<() -> Void>] {
        let basetype = TypeInfo((() -> Void).self).baseTypename
        return node.allNodes.filter { $0.typeInfo.typename.hasSuffix(basetype) }.map(TypedNodeReflection.init)
    }

    var strings: [TypedNodeReflection<String>] { valueNodes() }

    var images: [ImageReflection] { valueNodes() }

    var texts: [TextReflection] { valueNodes() }

    var bindings: [BindingReflection] {
        genericTypeNodes()
    }

    var states: [StateReflection] {
        genericTypeNodes()
    }

    var toggles: [ToggleReflection] {
        genericTypeNodes()
    }

    var buttons: [ButtonReflection] {
        genericTypeNodes()
    }

    var refreshableModifiers: [RefreshableReflection] {
        func isRefreshableModifier(_ ref: ReflectionNode) -> Bool {
            ref.typeInfo.baseTypename.hasPrefix("SwiftUI.") && ref.typeInfo.baseTypename.hasSuffix(".RefreshableModifier")
        }
        return node.allNodes.filter { isRefreshableModifier($0) }.map(RefreshableReflection.init)
    }

    var taskModifiers: [TaskReflection] {
        func isRefreshableModifier(_ ref: ReflectionNode) -> Bool {
            ref.typeInfo.baseTypename.hasPrefix("SwiftUI.") && ref.typeInfo.baseTypename.hasSuffix("._TaskModifier")
        }
        return node.allNodes.filter { isRefreshableModifier($0) }.map(TaskReflection.init)
    }

    var onAppearModifiers: [OnAppearReflection] {
        func isRefreshableModifier(_ ref: ReflectionNode) -> Bool {
            ref.typeInfo.baseTypename.hasPrefix("SwiftUI.") && ref.typeInfo.baseTypename.hasSuffix("._AppearanceActionModifier")
        }
        return node.allNodes.filter { isRefreshableModifier($0) }.map(OnAppearReflection.init)
    }
}
