import SwiftUI

@MainActor @propertyWrapper public struct Loadable: DynamicProperty {
    @State var taskWrapper = TaskWrapper()
    public init() {}
    @State public var wrappedValue = LoadingState()
    public var projectedValue: Binding<LoadingState> { $wrappedValue }
}

@MainActor public extension Loadable {
    func loadAsync(_ asyncThrowingFunc: @MainActor () async throws -> Void) async {
        await projectedValue.load(asyncThrowingFunc)
    }

    func loadSync(_ asyncThrowingFunc: @escaping @MainActor () async throws -> Void) {
        $taskWrapper.load { @MainActor in
            await loadAsync(asyncThrowingFunc)
        }
    }
}

@MainActor public extension View {
    @ViewBuilder func taskLoadable(_ loadable: Loadable) -> some View {
        taskWrapper(loadable.taskWrapper)
    }
}
