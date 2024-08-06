import SwiftUI
import XCTest

final class TypeInfoTests: XCTestCase {
    func testTypeInfoBinding() {
        let t1 = TypeUtils.typename(Binding<Int>.self)
        let b: Binding<Int> = .constant(1)
        let t2 = TypeUtils.typename(object: b)
        XCTAssertEqual(t1, t2)
        XCTAssertEqual(t1, "SwiftUI.Binding<Swift.Int>")
        XCTAssertEqual(TypeUtils.basetype(t1), "SwiftUI.Binding")
    }

    func testTypeInfoInt() {
        let t1 = TypeUtils.typename(Int.self)
        let int = 0
        let t2 = TypeUtils.typename(object: int)
        XCTAssertEqual(t1, t2)
        XCTAssertEqual(t1, "Swift.Int")
        XCTAssertEqual(TypeUtils.basetype(t1), "Swift.Int")
    }
}
