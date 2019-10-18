import XCTest
@testable import algorithms

final class fibonacciTests: XCTestCase {
  
  func testFibonacci() {
    XCTAssertEqual(fibonacci(1), 1)
    XCTAssertEqual(fibonacci(2), 1)
    XCTAssertEqual(fibonacci(3), 2)
    XCTAssertEqual(fibonacci(4), 3)
    XCTAssertEqual(fibonacci(5), 5)
    XCTAssertEqual(fibonacci(6), 8)
    XCTAssertEqual(fibonacci(7), 13)
  }
  
  static var allTests = [
    ("testFibonacci", testFibonacci),
  ]
}
