struct RefreshableReflection: ReflectionNodeWrapper {
    let node: ReflectionNode

    func doRefresh() async {
        await asyncActions[0].value()
    }
}

struct TaskReflection: ReflectionNodeWrapper {
    let node: ReflectionNode

    func runTask() async {
        await asyncActions[0].value()
    }
}

struct OnAppearReflection: ReflectionNodeWrapper {
    let node: ReflectionNode

    func doOnAppear() {
        actions[0].value()
    }
}
