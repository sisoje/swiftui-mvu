import SwiftUI
@testable import SwiftuiNative
import XCTest

final class LoadableTests: HostingTestsBase {}

@MainActor extension LoadableTests {
    func testLoadAsync() async throws {
        struct Dummy: View {
            @LoadableValue var number = 0
            var state: LoadingState { _number.state }
            var body: some View {
                let _ = postBodyEvaluationNotification()
                number.task {
                    await _number.loadAsync { await .asyncInc(number) }
                }
            }
        }
        
        ViewHosting.hostView {
            Dummy()
        }

        let view = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 0)
        XCTAssertEqual(view.state.isLoading, false)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 0)
        XCTAssertEqual(view.state.isLoading, true)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 1)
        XCTAssertEqual(view.state.isLoading, false)
    }

    func testLoadSync() async throws {
        struct Dummy: View {
            @LoadableValue var number = 0
            var state: LoadingState { _number.state }
            var body: some View {
                let _ = postBodyEvaluationNotification()
                number.onAppear {
                    _number.loadSync {  await .asyncInc(number) }
                }
                .taskLoadable(_number.loadable)
            }
        }

        ViewHosting.hostView {
            Dummy()
        }

        let view = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 0)
        XCTAssertEqual(view.state.isLoading, false)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 0)
        XCTAssertEqual(view.state.isLoading, true)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 1)
        XCTAssertEqual(view.state.isLoading, false)
    }
}
