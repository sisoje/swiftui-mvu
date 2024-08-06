struct RefreshableWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    func doRefresh() async {
        await asyncActions[0].value()
    }
}

struct TaskWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    func runTask() async {
        await asyncActions[0].value()
    }
}

struct OnAppearWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    func doOnAppear() {
        actions[0].value()
    }
}
