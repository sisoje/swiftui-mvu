import Foundation

struct TypeInfo: Equatable {
    let typename: String
    
    var baseTypename: String {
        typename.components(separatedBy: "<")[0]
    }
    
    init(object: Any) {
        typename = String(reflecting: type(of: object))
    }
    
    init<T>(_ type: T.Type = T.self) {
        typename = String(reflecting: T.self)
    }
}
