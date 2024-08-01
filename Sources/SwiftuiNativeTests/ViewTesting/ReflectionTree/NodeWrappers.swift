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

extension ButtonNodeWrapper {
    @MainActor func tap() {
        let (actions1, actions2, actions3) = (actions1, actions2, actions3)
        if let action = actions1.first {
            action.value()
        } else if let action = actions2.first {
            action.value()
        } else if let action = actions3.first {
            action.value()
        } else {
            assertionFailure()
        }
    }
}

extension ToggleNodeWrapper {
    @MainActor var isOn: Binding<Bool> {
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
    
    @MainActor func toggle() {
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

    @MainActor var value: T {
        node.object as! T
    }
}

extension ValueNodeWrapper<Text> {
    @MainActor var string: String {
        strings[0].value
    }
}
