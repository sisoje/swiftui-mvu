//
//  File.swift
//  
//
//  Created by Lazar on 14/07/2024.
//

import SwiftUI

struct ViewSnapshot<T: View> {
    let viewReflection: ValueNodeWrapper<T>
    let body: ReflectionNodeWrapper
}

@MainActor extension View {    
    var viewSnapshot: ViewSnapshot<Self> {
        ViewSnapshot(
            viewReflection: ValueNodeWrapper(node: ReflectionNode(object: self)),
            body: ReflectionNode(object: body)
        )
    }
}
