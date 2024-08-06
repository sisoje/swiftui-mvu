import SwiftUI

typealias TextReflection = TypeNodeReflection<Text>
typealias ImageReflection = TypeNodeReflection<Image>

extension TextReflection {
    var string: String {
        strings[0].value
    }
}
