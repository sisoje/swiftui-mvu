import SwiftUI
import SwiftuiNative
import XCTest

final class StatefulViewTests: XCTestCase {
    @MainActor override func setUp() async throws {
        guard ViewHosting.hostView != nil else {
            throw XCTSkip("stateful view need hosting")
        }
    }
}

@MainActor extension StatefulViewTests {
    func testTask() async throws {
        struct DummyView: View {
            @State var count = 0
            var body: some View {
                let _ = postBodyEvaluationNotification()
                Text("Test \(count)")
                    .task {
                        count += 1
                    }
            }
        }
        
        ViewHosting.hostView {
            DummyView()
        }
        
        let view = try await DummyView.getTestView()
        XCTAssertEqual(view.count, 0)
        _ = try await DummyView.getTestView()
        XCTAssertEqual(view.count, 1)
    }
    
    func testToggle() async throws {
        struct DummyView: View {
            @State var isOn = false
            var body: some View {
                let _ = postBodyEvaluationNotification()
                Toggle("Test", isOn: $isOn)
            }
        }
        
        ViewHosting.hostView {
            DummyView()
        }
        
        let view = try await DummyView.getTestView()
        let toggle = view.viewSnapshot.body.toggles[0]
        XCTAssertEqual(toggle.texts.map(\.string), ["Test"])
        XCTAssertEqual(view.isOn, false)
        toggle.toggle()
        XCTAssertEqual(view.isOn, true)
    }
    
    func testButton() async throws {
        struct DummyView: View {
            @State var counter = 0
            var body: some View {
                let _ = postBodyEvaluationNotification()
                Button("Add") { counter += 1 }
            }
        }
        
        ViewHosting.hostView {
            DummyView()
        }
        
        let view = try await DummyView.getTestView()
        let button = view.viewSnapshot.body.buttons[0]
        XCTAssertEqual(button.texts.map(\.string), ["Add"])
        XCTAssertEqual(view.counter, 0)
        button.tap()
        XCTAssertEqual(view.counter, 1)
    }
}
