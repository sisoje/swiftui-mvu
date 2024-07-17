//
//  File.swift
//  
//
//  Created by Lazar on 15/07/2024.
//

import Foundation

struct TypeInfo: Equatable {
    let typename: String
    let basetype: String
    let subtype: String
    
    private init(typename: String) {
        self.typename = typename
        let spl = typename.components(separatedBy: "<")
        basetype = spl[0]
        subtype = spl.dropFirst().joined(separator: "<").components(separatedBy: ">").dropLast().joined(separator: ">")
    }
    
    init(object: Any) {
        self.init(typename: String(reflecting: type(of: object)))
    }
    
    init<T>(_ type: T.Type = T.self) {
        self.init(typename: String(reflecting: type))
    }
}
