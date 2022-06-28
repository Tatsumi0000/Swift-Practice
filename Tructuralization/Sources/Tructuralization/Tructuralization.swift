import Foundation

public struct Tructuralization {
    let a: Int
    let b: Int 

    public init(a: Int, b: Int) {
        self.a = a
        self.b = b
    }

    public func add() -> Int {
        return a + b
    }

    public func subtract() -> Int {
        return a - b
    }
}
