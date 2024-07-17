import SwiftUI

enum ViewHosting {
    @MainActor static var hostView: (@MainActor (@MainActor () -> any View) -> Void)!
}
