//
//  NodeWrappers.swift
//  Part2Tests
//
//  Created by Lazar on 09/07/2024.
//

import Foundation
import SwiftUI

protocol ReflectionNodeWrapper {
    var node: ReflectionNode { get }
}

struct DynamicNodeWrapper<BASE>: ReflectionNodeWrapper {
    let node: ReflectionNode
    
    static var baseTypeinfo: TypeInfo {
        TypeInfo(BASE.self)
    }
    
    func castAs<T>(_ t: T.Type = T.self) -> T? {
        node.object as? T
    }
    
    func memoryCast<T>(_ t: T.Type = T.self) -> T {
        CastingUtils.memoryCast(node.object, T.self)
    }
}

typealias BindingNodeWrapper = DynamicNodeWrapper<Binding<Any>>
typealias StateNodeWrapper = DynamicNodeWrapper<State<Any>>
typealias ToggleNodeWrapper = DynamicNodeWrapper<Toggle<AnyView>>
typealias ButtonNodeWrapper = DynamicNodeWrapper<Button<AnyView>>

@MainActor extension ButtonNodeWrapper {
    func tap() {
        if let actionNode = mainActorActions.first {
            actionNode.value()
        } else {
            actions[0].value()
        }
    }
}

@MainActor extension ToggleNodeWrapper {
    var isOn: Binding<Bool> {
        let binding = bindings[0]
        if let boolBinding = binding.castAs(Binding<Bool>.self) {
            return boolBinding
        }
        let dummyBinding = binding.memoryCast(Binding<CastingUtils.DummyEnum>.self)
        return Binding {
            dummyBinding.wrappedValue == .case0
        } set: {
            dummyBinding.wrappedValue = $0 ? .case0 : .case1
        }
    }
    
    func toggle() {
        isOn.wrappedValue.toggle()
    }
}

struct RefreshableNodeWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    @MainActor func refresh() async {
        await asyncActions[0].value()
    }
}

struct ValueNodeWrapper<T>: ReflectionNodeWrapper {
    let node: ReflectionNode

    var value: T {
        node.object as! T
    }
}

@MainActor extension ValueNodeWrapper<Text> {
    var string: String {
        strings[0].value
    }
}
