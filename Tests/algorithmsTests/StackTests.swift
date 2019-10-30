import XCTest
@testable import algorithms

final class StackTests: XCTestCase {
  
  func test_stack() {
    var stack = Stack<Int>()
    XCTAssertTrue(stack.isEmpty);
    XCTAssertEqual(stack.pop(), nil)
  
    stack.push(1)
    XCTAssertFalse(stack.isEmpty);
    
    stack.push(2)
    XCTAssertFalse(stack.isEmpty);
    
    stack.push(3)
    XCTAssertFalse(stack.isEmpty);
    
    XCTAssertEqual(stack.pop(), 3)
    XCTAssertFalse(stack.isEmpty);
    
    XCTAssertEqual(stack.pop(), 2)
    XCTAssertFalse(stack.isEmpty);
    
    XCTAssertEqual(stack.pop(), 1)
    XCTAssertTrue(stack.isEmpty);
    
    XCTAssertEqual(stack.pop(), nil)
    XCTAssertTrue(stack.isEmpty);
  }
  
  static var allTests = [
    ("test_stack", test_stack),
  ]
}
