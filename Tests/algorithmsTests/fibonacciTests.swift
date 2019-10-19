import XCTest
@testable import algorithms

final class fibonacciTests: XCTestCase {
  
  func test_fibonacci1() {
    XCTAssertEqual(fibonacci1(1), 1)
    XCTAssertEqual(fibonacci1(2), 1)
    XCTAssertEqual(fibonacci1(3), 2)
    XCTAssertEqual(fibonacci1(4), 3)
    XCTAssertEqual(fibonacci1(5), 5)
    XCTAssertEqual(fibonacci1(6), 8)
    XCTAssertEqual(fibonacci1(7), 13)
  }
  
  func test_fibonacci2() {
    XCTAssertEqual(fibonacci2(1), 1)
    XCTAssertEqual(fibonacci2(2), 1)
    XCTAssertEqual(fibonacci2(3), 2)
    XCTAssertEqual(fibonacci2(4), 3)
    XCTAssertEqual(fibonacci2(5), 5)
    XCTAssertEqual(fibonacci2(6), 8)
    XCTAssertEqual(fibonacci2(7), 13)
  }
  
  static var allTests = [
    ("test_fibonacci1", test_fibonacci1),
    ("test_fibonacci2", test_fibonacci2),
  ]
}
