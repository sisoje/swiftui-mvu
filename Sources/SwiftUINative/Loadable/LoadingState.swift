import SwiftUI

public struct LoadingState {
    public var isLoading = false
    public var error: Error?
}

@MainActor extension Binding<LoadingState> {
    func load(_ throwableFunc: () async throws -> Void) async {
        DebugLogger.debugLogger?.info("load starting")
        wrappedValue = LoadingState(isLoading: true)
        do {
            try await throwableFunc()
            DebugLogger.debugLogger?.info("load ok")
        }
        catch is CancellationError {
            DebugLogger.debugLogger?.warning("load cancelled")
            return
        }
        catch {
            DebugLogger.debugLogger?.error("load error")
            wrappedValue.error = error
        }
        DebugLogger.debugLogger?.info("load ending")
        wrappedValue.isLoading = false
    }
}
