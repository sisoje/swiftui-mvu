protocol ReflectionNodeWrapper {
    var node: ReflectionNode { get }
}

extension ReflectionNodeWrapper {
    func genericTypeNodes<T>() -> [DynamicNodeWrapper<T>] {
        let typeInfo = TypeInfo(T.self)
        return node.allNodes.filter { $0.typeInfo.basetype == typeInfo.basetype }.map(DynamicNodeWrapper<T>.init)
    }
    
    func valueNodes<T>(_ t: T.Type = T.self) -> [ValueNodeWrapper<T>] {
        node.allNodes.filter { $0.object is T }.map(ValueNodeWrapper.init)
    }

    var asyncActions: [ValueNodeWrapper<() async -> Void>] {
        let t = TypeInfo((() async -> Void).self)
        return node.allNodes.filter { $0.typeInfo.typename.hasSuffix(t.typename) }.map(ValueNodeWrapper.init)
    }

    var actions: [ValueNodeWrapper<() -> Void>] {
        let t = TypeInfo((() -> Void).self)
        return node.allNodes.filter { $0.typeInfo.typename.hasSuffix(t.typename) }.map(ValueNodeWrapper.init)
    }

    var strings: [ValueNodeWrapper<String>] { valueNodes() }

    var images: [ImageWrapper] { valueNodes() }

    var texts: [TextWrapper] { valueNodes() }

    var bindings: [BindingNodeWrapper] {
        genericTypeNodes()
    }

    var states: [StateNodeWrapper] {
        genericTypeNodes()
    }

    var toggles: [ToggleNodeWrapper] {
        genericTypeNodes()
    }

    var buttons: [ButtonNodeWrapper] {
        genericTypeNodes()
    }
    
    var refreshableModifiers: [RefreshableWrapper] {
        func isRefreshableModifier(_ ref: ReflectionNode) -> Bool {
            ref.typeInfo.basetype.hasPrefix("SwiftUI.") && ref.typeInfo.basetype.hasSuffix(".RefreshableModifier")
        }
        return node.allNodes.filter { isRefreshableModifier($0) }.map(RefreshableWrapper.init)
    }
    
    var taskModifiers: [TaskWrapper] {
        func isRefreshableModifier(_ ref: ReflectionNode) -> Bool {
            ref.typeInfo.basetype.hasPrefix("SwiftUI.") && ref.typeInfo.basetype.hasSuffix("._TaskModifier")
        }
        return node.allNodes.filter { isRefreshableModifier($0) }.map(TaskWrapper.init)
    }
    
    var onAppearModifiers: [OnAppearWrapper] {
        func isRefreshableModifier(_ ref: ReflectionNode) -> Bool {
            ref.typeInfo.basetype.hasPrefix("SwiftUI.") && ref.typeInfo.basetype.hasSuffix("._AppearanceActionModifier")
        }
        return node.allNodes.filter { isRefreshableModifier($0) }.map(OnAppearWrapper.init)
    }
}
