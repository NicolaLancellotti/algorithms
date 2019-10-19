import XCTest
@testable import algorithms

final class fibonacciTests: XCTestCase {
  
  func testFibonacci1() {
    XCTAssertEqual(fibonacci1(1), 1)
    XCTAssertEqual(fibonacci1(2), 1)
    XCTAssertEqual(fibonacci1(3), 2)
    XCTAssertEqual(fibonacci1(4), 3)
    XCTAssertEqual(fibonacci1(5), 5)
    XCTAssertEqual(fibonacci1(6), 8)
    XCTAssertEqual(fibonacci1(7), 13)
  }
  
  func testFibonacci2() {
    XCTAssertEqual(fibonacci2(1), 1)
    XCTAssertEqual(fibonacci2(2), 1)
    XCTAssertEqual(fibonacci2(3), 2)
    XCTAssertEqual(fibonacci2(4), 3)
    XCTAssertEqual(fibonacci2(5), 5)
    XCTAssertEqual(fibonacci2(6), 8)
    XCTAssertEqual(fibonacci2(7), 13)
  }
  
  static var allTests = [
    ("testFibonacci1", testFibonacci1),
    ("testFibonacci2", testFibonacci2),
  ]
}
