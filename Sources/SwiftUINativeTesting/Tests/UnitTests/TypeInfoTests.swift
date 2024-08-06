import SwiftUI
import XCTest

final class TypeInfoTests: XCTestCase {
    func testTypeInfoBinding() {
        let t1 = TypeInfo(Binding<Int>.self)
        let b: Binding<Int> = .constant(1)
        let t2 = TypeInfo(object: b)
        XCTAssertEqual(t1, t2)
        XCTAssertEqual(t1.typename, "SwiftUI.Binding<Swift.Int>")
        XCTAssertEqual(t1.baseTypename, "SwiftUI.Binding")
    }

    func testTypeInfoInt() {
        let t1 = TypeInfo(Int.self)
        let int = 0
        let t2 = TypeInfo(object: int)
        XCTAssertEqual(t1, t2)
        XCTAssertEqual(t1.typename, "Swift.Int")
        XCTAssertEqual(t1.baseTypename, "Swift.Int")
    }
}
