import SwiftUI

typealias TextWrapper = ValueNodeWrapper<Text>
typealias ImageWrapper = ValueNodeWrapper<Image>

@MainActor extension TextWrapper {
    var string: String {
        strings[0].value
    }
}
