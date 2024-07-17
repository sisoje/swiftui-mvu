import SwiftUI
@testable import SwiftuiNative
import XCTest

final class LoadableTests: HostingTestsBase {}

@MainActor extension LoadableTests {
    func testLoadAsync() async throws {
        struct Dummy: View {
            @State var number = 0
            @Loadable var loadable
            var body: some View {
                let _ = postBodyEvaluationNotification()
                number.task {
                    await _loadable.loadAsync { number = await .asyncInc(number) }
                }
                .disabled(loadable.isLoading)
            }
        }
        
        ViewHosting.hostView {
            Dummy()
        }

        let view = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 0)
        XCTAssertEqual(view.loadable.isLoading, false)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 0)
        XCTAssertEqual(view.loadable.isLoading, true)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 1)
        XCTAssertEqual(view.loadable.isLoading, false)
    }

    func testLoadSync() async throws {
        struct Dummy: View {
            @State var number = 0
            @Loadable var loadable
            var body: some View {
                let _ = postBodyEvaluationNotification()
                number.onAppear {
                    _loadable.loadSync { number = await .asyncInc(number) }
                }
                .taskLoadable(_loadable)
                .disabled(loadable.isLoading)
            }
        }

        ViewHosting.hostView {
            Dummy()
        }

        let view = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 0)
        XCTAssertEqual(view.loadable.isLoading, false)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 0)
        XCTAssertEqual(view.loadable.isLoading, true)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 1)
        XCTAssertEqual(view.loadable.isLoading, false)
    }
}
