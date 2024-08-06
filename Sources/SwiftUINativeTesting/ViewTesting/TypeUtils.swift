import Foundation

enum TypeUtils {
    static func basetype(_ typename: String) -> String {
        typename.components(separatedBy: "<")[0]
    }
    
    static func typename(object: Any) -> String {
        String(reflecting: type(of: object))
    }
    
    static func typename<T>(_ type: T.Type = T.self) -> String {
        String(reflecting: T.self)
    }
}
