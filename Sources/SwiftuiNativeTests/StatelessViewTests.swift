import SwiftUI
import XCTest

final class StatelessViewTests: XCTestCase {}

@MainActor extension StatelessViewTests {
    func testToggle() {
        struct DummyView: View {
            @Binding var isOn: Bool
            var body: some View {
                Toggle("Test", isOn: $isOn)
            }
        }

        let view = DummyView(isOn: .variable(false))
        let toggle = view.viewSnapshot.body.toggles[0]
        XCTAssertEqual(toggle.texts.map(\.string), ["Test"])
        XCTAssertEqual(view.isOn, false)
        toggle.toggle()
        XCTAssertEqual(view.isOn, true)
    }

    func testButton() {
        struct DummyView: View {
            @Binding var counter: Int
            var body: some View {
                Button("Add") { counter += 1 }
            }
        }

        let view = DummyView(counter: .variable(0))
        let button = view.viewSnapshot.body.buttons[0]
        XCTAssertEqual(button.texts.map(\.string), ["Add"])
        XCTAssertEqual(view.counter, 0)
        button.tap()
        XCTAssertEqual(view.counter, 1)
    }
}
