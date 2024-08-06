import SwiftUI
import XCTest

final class ModifierTests: XCTestCase {}

@MainActor extension ModifierTests {
    func testRefreshable() async {
        var x = 0
        let viewSnapshot = EmptyView().refreshable { x = 1 }.reflectionSnapshot
        let modifiers = viewSnapshot.refreshableModifiers
        XCTAssertEqual(modifiers.count, 1)
        await modifiers[0].doRefresh()
        XCTAssert(x == 1)
    }
    
    func testTask() async {
        var x = 0
        let viewSnapshot = EmptyView().task { x = 1 }.reflectionSnapshot
        let modifiers = viewSnapshot.taskModifiers
        XCTAssertEqual(modifiers.count, 1)
        await modifiers[0].runTask()
        XCTAssert(x == 1)
    }
    
    func testOnAppear() {
        var x = 0
        let viewSnapshot = EmptyView().onAppear { x = 1 }.reflectionSnapshot
        let modifiers = viewSnapshot.onAppearModifiers
        XCTAssertEqual(modifiers.count, 1)
        modifiers[0].doOnAppear()
        XCTAssert(x == 1)
    }
}
