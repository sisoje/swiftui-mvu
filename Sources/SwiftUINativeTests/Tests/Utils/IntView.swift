import SwiftUI

extension Int: View {
    public var body: Text { Text("") }
}

extension Int {
    @MainActor static func asyncInc(_ number: Int) async -> Int {
        await Task { @MainActor in await Task.yield() }.value
        return number + 1
    }
}
