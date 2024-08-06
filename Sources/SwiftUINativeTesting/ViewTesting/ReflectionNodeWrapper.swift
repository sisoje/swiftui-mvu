protocol ReflectionNodeWrapper {
    var node: ReflectionNode { get }
}

extension ReflectionNodeWrapper {
    func genericTypeNodes<T>() -> [GenericNodeReflection<T>] {
        let basetype = TypeUtils.basetype(TypeUtils.typename(T.self))
        return node.allNodes.filter { $0.basetype == basetype }.map(GenericNodeReflection<T>.init)
    }
    
    func valueNodes<T>(_ t: T.Type = T.self) -> [TypeNodeReflection<T>] {
        node.allNodes.filter { $0.object is T }.map(TypeNodeReflection.init)
    }

    var asyncActions: [TypeNodeReflection<() async -> Void>] {
        let basetype = TypeUtils.basetype(TypeUtils.typename((() async -> Void).self))
        return node.allNodes.filter { $0.typename.hasSuffix(basetype) }.map(TypeNodeReflection.init)
    }

    var actions: [TypeNodeReflection<() -> Void>] {
        let basetype = TypeUtils.basetype(TypeUtils.typename((() -> Void).self))
        return node.allNodes.filter { $0.typename.hasSuffix(basetype) }.map(TypeNodeReflection.init)
    }

    var strings: [TypeNodeReflection<String>] { valueNodes() }

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
            ref.basetype.hasPrefix("SwiftUI.") && ref.basetype.hasSuffix(".RefreshableModifier")
        }
        return node.allNodes.filter { isRefreshableModifier($0) }.map(RefreshableReflection.init)
    }
    
    var taskModifiers: [TaskReflection] {
        func isRefreshableModifier(_ ref: ReflectionNode) -> Bool {
            ref.basetype.hasPrefix("SwiftUI.") && ref.basetype.hasSuffix("._TaskModifier")
        }
        return node.allNodes.filter { isRefreshableModifier($0) }.map(TaskReflection.init)
    }
    
    var onAppearModifiers: [OnAppearReflection] {
        func isRefreshableModifier(_ ref: ReflectionNode) -> Bool {
            ref.basetype.hasPrefix("SwiftUI.") && ref.basetype.hasSuffix("._AppearanceActionModifier")
        }
        return node.allNodes.filter { isRefreshableModifier($0) }.map(OnAppearReflection.init)
    }
}
