import XCTest

class TypeInfoTests: XCTestCase {
    func testTypeInfoBinding() {
        let t1 = TypeInfo(Binding<Any>.self)
        let b: Binding<Any> = .constant(1)
        let t2 = TypeInfo(object: b)
        XCTAssertEqual(t1, t2)
    }
    
    func testTypeInfoInt() {
        let t1 = TypeInfo(Int.self)
        let int: Int = 0
        let t2 = TypeInfo(object: int)
        XCTAssertEqual(t1, t2)
    }
}
