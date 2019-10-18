import XCTest
@testable import algorithms

final class algorithmsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(algorithms().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
