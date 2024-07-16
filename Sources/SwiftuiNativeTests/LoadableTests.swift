import SwiftuiNative
import XCTest
import SwiftUI

@MainActor extension StatefulViewTests {
    func testLoadableAsync() async throws {
        struct Dummy: View {
            @State var t = 0
            @Loadable var loadable
            var body: some View {
                let _ = postBodyEvaluationNotification()
                Text("Test \(t)")
                    .task {
                        await _loadable.loadAsync { t += 1 }
                    }
            }
        }
        ViewHosting.hostView {
            Dummy()
        }
        
        let view = try await Dummy.getTestView()
        XCTAssertEqual(view.t, 0)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.t, 1)
    }
    
    func testLoadableSync() async throws {
        struct Dummy: View {
            @State var t = 0
            @Loadable var loadable
            var body: some View {
                let _ = postBodyEvaluationNotification()
                Text("Test \(t)")
                    .onAppear {
                        _loadable.loadSync { t += 1 }
                    }
                    .taskLoadable(_loadable)
            }
        }
        ViewHosting.hostView {
            Dummy()
        }
        
        let view = try await Dummy.getTestView()
        XCTAssertEqual(view.t, 0)
        _ = try await Dummy.getTestView()
        XCTAssertEqual(view.t, 1)
    }
}
