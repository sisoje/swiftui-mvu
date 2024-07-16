import SwiftUI

public enum ViewHosting {
    @MainActor public static var hostView: (@MainActor (@MainActor () -> any View) -> Void)!
}
