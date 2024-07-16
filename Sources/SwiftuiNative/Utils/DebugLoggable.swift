import OSLog

public protocol DebugLoggable {
    var debugLogger: Logger? { get }
}

public extension DebugLoggable {
    var debugLogger: Logger? { Self.debugLogger }
    static var debugLogger: Logger? {
        var logger: Logger?
        assert({
            logger = Logger(
                subsystem: String(reflecting: Self.self).components(separatedBy: ".")[0],
                category: String(describing: Self.self)
            )
        }() == ())
        return logger
    }
}
