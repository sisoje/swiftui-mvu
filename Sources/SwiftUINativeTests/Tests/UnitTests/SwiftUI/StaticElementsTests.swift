import SwiftUI
import XCTest

final class StaticElementsTests: XCTestCase {}

@MainActor extension StaticElementsTests {
    func testText() {
        XCTAssertEqual(Text("a").reflectionSnapshot.texts[0].string, "a")
    }
    
    func testImage() {
        XCTAssertEqual(Image(systemName: "circle").reflectionSnapshot.images.count, 1)
    }
}
