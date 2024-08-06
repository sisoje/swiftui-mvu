struct RefreshableWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    @MainActor func doRefresh() async {
        await asyncActions[0].value()
    }
}

struct TaskWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    @MainActor func runTask() async {
        await asyncActions[0].value()
    }
}

struct OnAppearWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    @MainActor func doOnAppear() {
        actions[0].value()
    }
}
