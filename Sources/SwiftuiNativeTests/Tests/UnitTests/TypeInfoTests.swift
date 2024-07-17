import SwiftUI
import XCTest

final class TypeInfoTests: XCTestCase {
    func testTypeInfoBinding() {
        let t1 = TypeInfo(Binding<Any>.self)
        let b: Binding<Any> = .constant(1)
        let t2 = TypeInfo(object: b)
        XCTAssertEqual(t1, t2)
        XCTAssertEqual(t1.basetype, "SwiftUI.Binding")
        XCTAssertEqual(t1.subtype, "Any")
        XCTAssertEqual(t1.typename, "SwiftUI.Binding<Any>")
    }

    func testTypeInfoInt() {
        let t1 = TypeInfo(Int.self)
        let int = 0
        let t2 = TypeInfo(object: int)
        XCTAssertEqual(t1, t2)
        XCTAssertEqual(t1.basetype, "Swift.Int")
        XCTAssertEqual(t1.subtype, "")
        XCTAssertEqual(t1.typename, "Swift.Int")
    }
}
