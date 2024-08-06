import SwiftUI

typealias ToggleNodeWrapper = DynamicNodeWrapper<Toggle<AnyView>>
typealias ButtonNodeWrapper = DynamicNodeWrapper<Button<AnyView>>

extension ButtonNodeWrapper {
    func tap() {
        actions[0].value()
    }
}

extension ToggleNodeWrapper {
    var isOn: Binding<Bool> {
        let binding = bindings[0]
        if let boolBinding = binding.cast(Binding<Bool>.self) {
            return boolBinding
        }
        let dummyBinding = binding.forceCast(Binding<CastingUtils.DummyEnum>.self)
        return Binding {
            dummyBinding.wrappedValue == .case0
        } set: {
            dummyBinding.wrappedValue = $0 ? .case0 : .case1
        }
    }

    func toggle() {
        isOn.wrappedValue.toggle()
    }
}
