enum CastingUtils {
    static func memoryCast<T1, T2>(_ x: T1, _ t: T2.Type = T2.self) -> T2 {
        withUnsafePointer(to: x) {
            $0.withMemoryRebound(to: T2.self, capacity: 1) { $0.pointee }
        }
    }
}
