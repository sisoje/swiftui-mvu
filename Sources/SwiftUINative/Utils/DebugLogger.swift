import OSLog

public protocol DebugLoggable {
    static var debugLogger: Logger? { get }
}

public extension DebugLoggable {
    var debugLogger: Logger? { Self.debugLogger }
    static var debugLogger: Logger? {
        var logger: Logger?
        assert({
            logger = Logger(
                subsystem: Bundle.main.bundleIdentifier ?? "",
                category: String(describing: Self.self)
            )
        }() == ())
        return logger
    }
}

enum DebugLogger: DebugLoggable {}
