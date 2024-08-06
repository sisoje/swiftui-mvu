import SwiftUI

typealias TextWrapper = ValueNodeWrapper<Text>
typealias ImageWrapper = ValueNodeWrapper<Image>

extension TextWrapper {
    var string: String {
        strings[0].value
    }
}
