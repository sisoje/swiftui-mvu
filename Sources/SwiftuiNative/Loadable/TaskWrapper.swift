import SwiftUI

struct TaskWrapper {
    @MainActor static var debugIds: Set<UUID> = []
    private(set) var id = UUID()
    private(set) var asyncFunction: @Sendable () async -> Void = {}
    mutating func setAsyncFunction(_ asyncFunction: @escaping @Sendable () async -> Void) {
        id = UUID()
        self.asyncFunction = asyncFunction
    }
}

@MainActor extension Binding<TaskWrapper> {
    func load(_ asyncFunc: @escaping @Sendable () async -> Void) {
        assert(TaskWrapper.debugIds.remove(wrappedValue.id) != nil, "task modifier needs to be applied first")
        wrappedValue.setAsyncFunction(asyncFunc)
    }
}

@MainActor extension View {
    @ViewBuilder func taskWrapper(_ wrapper: TaskWrapper) -> some View {
        let _ = assert(TaskWrapper.debugIds.insert(wrapper.id).inserted.description.isContiguousUTF8, "mark task modifier as applied")
        task(id: wrapper.id, wrapper.asyncFunction)
    }
}
