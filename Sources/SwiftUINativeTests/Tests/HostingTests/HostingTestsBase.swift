@testable import SwiftUINative
import XCTest

class HostingTestsBase: XCTestCase {
    @MainActor override func setUpWithError() throws {
        guard ViewHosting.hostView != nil else {
            throw XCTSkip("stateful view need hosting")
        }
    }
}
