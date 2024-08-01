//
//  File.swift
//
//
//  Created by Lazar on 12/07/2024.
//

import Foundation
import SwiftUI

extension ReflectionNodeWrapper {
    func valueNodes<T>(_ t: T.Type = T.self) -> [ValueNodeWrapper<T>] {
        node.allNodes.filter { $0.object is T }.map(ValueNodeWrapper.init)
    }

    var asyncActions: [ValueNodeWrapper< @Sendable () async -> Void>] { valueNodes() }

    var actions: [ValueNodeWrapper<() -> Void>] { valueNodes() }
    var mainActorActions: [ValueNodeWrapper<@MainActor () -> Void>] { valueNodes() }

    var strings: [ValueNodeWrapper<String>] { valueNodes() }

    var images: [ValueNodeWrapper<Image>] { valueNodes() }

    var texts: [ValueNodeWrapper<Text>] { valueNodes() }

    var bindings: [BindingNodeWrapper] {
        node.genericTypeNodes()
    }

    var states: [StateNodeWrapper] {
        node.genericTypeNodes()
    }

    var toggles: [ToggleNodeWrapper] {
        node.genericTypeNodes()
    }

    var buttons: [ButtonNodeWrapper] {
        node.genericTypeNodes()
    }

    var refreshableModifiers: [RefreshableNodeWrapper] {
        func isRefreshableModifier(_ ref: ReflectionNode) -> Bool {
            ref.typeInfo.basetype.hasPrefix("SwiftUI.") && ref.typeInfo.basetype.hasSuffix(".RefreshableModifier")
        }
        return node.allNodes.filter(isRefreshableModifier).map(RefreshableNodeWrapper.init)
    }
}
