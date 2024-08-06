import SwiftUI
import XCTest

final class PropertyWrappersTests: XCTestCase {}

@MainActor extension PropertyWrappersTests {
    func testState() {
        struct Dummy: View {
            @State var x = 0
            let body = EmptyView()
        }
        XCTAssertEqual(Dummy().reflectionSnapshot.states.count, 1)
    }
    
    func testBinding() {
        struct Dummy: View {
            @Binding var x: Int
            let body = EmptyView()
        }
        XCTAssertEqual(Dummy(x: .constant(1)).reflectionSnapshot.bindings.count, 1)
    }
}
