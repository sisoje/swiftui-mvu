import SwiftUI
@testable import SwiftUINative
import XCTest

final class ViewLifecycleTests: HostingTestsBase {}

@MainActor extension ViewLifecycleTests {
    func testOnAppear() async throws {
        struct DummyView: View {
            @State var number = 0
            var body: some View {
                let _ = postBodyEvaluationNotification()
                number.onAppear {
                    number += 1
                }
            }
        }
        
        ViewHosting.hostView {
            DummyView()
        }
        
        let view = try await DummyView.getTestView()
        XCTAssertEqual(view.number, 1)
    }
    
    func testTask() async throws {
        struct DummyView: View {
            @State var number = 0
            var body: some View {
                let _ = postBodyEvaluationNotification()
                number.task {
                    number = await .asyncInc(number)
                }
            }
        }
        
        ViewHosting.hostView {
            DummyView()
        }
        
        let view = try await DummyView.getTestView()
        XCTAssertEqual(view.number, 0)
        _ = try await DummyView.getTestView()
        XCTAssertEqual(view.number, 1)
    }
}

