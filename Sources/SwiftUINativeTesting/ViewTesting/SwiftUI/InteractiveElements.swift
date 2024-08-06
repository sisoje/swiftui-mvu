import SwiftUI

typealias ToggleReflection = GenericNodeReflection<Toggle<AnyView>>
typealias ButtonReflection = GenericNodeReflection<Button<AnyView>>

extension ButtonReflection {
    func tap() {
        actions[0].value()
    }
}

extension ToggleReflection {
    private enum DummyEnum {
        case case0
        case case1
    }
    
    var isOn: Binding<Bool> {
        let binding = bindings[0]
        if let boolBinding = binding.cast(Binding<Bool>.self) {
            return boolBinding
        }
        let dummyBinding = binding.forceCast(Binding<DummyEnum>.self)
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
