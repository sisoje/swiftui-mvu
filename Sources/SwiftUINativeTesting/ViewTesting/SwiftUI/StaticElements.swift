import SwiftUI

typealias TextReflection = TypedNodeReflection<Text>
typealias ImageReflection = TypedNodeReflection<Image>

extension TextReflection {
    var string: String {
        strings[0].value
    }
}
