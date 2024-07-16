import SwiftUI

public struct LoadingState {
    public var isLoading = false
    public var error: Error?
}

@MainActor extension Binding<LoadingState>: DebugLoggable {
    public func load(_ throwableFunc: () async throws -> Void) async {
        debugLogger?.info("load starting")
        wrappedValue = LoadingState(isLoading: true)
        do {
            try await throwableFunc()
            debugLogger?.info("load ok")
        }
        catch is CancellationError {
            debugLogger?.warning("load cancelled")
            return
        }
        catch {
            debugLogger?.error("load error")
            wrappedValue.error = error
        }
        debugLogger?.info("load ending")
        wrappedValue.isLoading = false
    }
}
