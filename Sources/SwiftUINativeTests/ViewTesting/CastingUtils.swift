//
//  Utils.swift
//  Part2Tests
//
//  Created by Lazar on 09/07/2024.
//

import Foundation

enum CastingUtils {   
    enum DummyEnum {
        case case0
        case case1
    }
    
    static func memoryCast<T1, T2>(_ x: T1, _ t: T2.Type = T2.self) -> T2 {
        withUnsafePointer(to: x) {
            $0.withMemoryRebound(to: T2.self, capacity: 1) { $0.pointee }
        }
    }
}
