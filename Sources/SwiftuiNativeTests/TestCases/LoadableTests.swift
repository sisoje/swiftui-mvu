import SwiftUI
import SwiftuiNative
import XCTest

@MainActor extension StatefulViewTests {
    func testLoadAsync() async throws {
        struct Dummy: View {
            @State var number = 0
            @Loadable private var loadable
            var body: some View {
                let _ = postBodyEvaluationNotification()
                number.task {
                    await _loadable.loadAsync { number += 1 }
                }
            }
        }
        ViewHosting.hostView {
            Dummy()
        }

        let view = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 0)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 1)
    }

    func testLoadSync() async throws {
        struct Dummy: View {
            @State var number = 0
            @Loadable private var loadable
            var body: some View {
                let _ = postBodyEvaluationNotification()
                number.onAppear {
                    _loadable.loadSync { number += 1 }
                }
                .taskLoadable(_loadable)
            }
        }
        
        ViewHosting.hostView {
            Dummy()
        }

        let view = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 0)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.number, 1)
    }
}
