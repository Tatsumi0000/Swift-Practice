import XCTest
@testable import Tructuralization

final class TructuralizationTests: XCTestCase {
   let tructuralization1 = Tructuralization(a: 1, b: 2)
    let tructuralization2 = Tructuralization(a: 10, b: 20)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPractice() {
        XCTContext.runActivity(named: "足し算のテスト") { _ in
            XCTAssertEqual(tructuralization1.add(), 3)
            XCTAssertEqual(tructuralization2.add(), 30)
        }

        XCTContext.runActivity(named: "引き算のテスト") { _ in
            XCTAssertEqual(tructuralization1.subtract(), -1)
            XCTAssertEqual(tructuralization2.subtract(), -10)
        }
    }
}
