import SwiftUI

@MainActor public struct ViewTestingApp: App {
    public init() {}
    @State private var view: any View = EmptyView()

    private func hostView(@ViewBuilder content: @MainActor () -> any View) {
        view = content().id(UUID())
    }

    public var body: some Scene {
        let _ = ViewHosting.hostView = hostView
        WindowGroup {
            AnyView(view)
        }
    }
}
