@testable import SwiftuiNative
import XCTest

class HostingTestsBase: XCTestCase {
    @MainActor override func setUp() async throws {
        guard ViewHosting.hostView != nil else {
            throw XCTSkip("stateful view need hosting")
        }
    }
}
