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
  
  func test_comparable() {
    do {
      var stack = Stack<Int>()
      stack.push(1)
      stack.push(2)
      XCTAssertEqual(stack, stack)
    }
    
    do {
      var stack1 = Stack<Int>()
      stack1.push(1)
      stack1.push(2)
      let stack2 = stack1
      stack1.pop()
      XCTAssertNotEqual(stack1, stack2)
    }
  }
  
  func test_hashable() {
    do {
      var stack = Stack<Int>()
      stack.push(1)
      stack.push(2)
      XCTAssertEqual(stack.hashValue, stack.hashValue)
    }
    
    do {
      var stack1 = Stack<Int>()
      stack1.push(1)
      stack1.push(2)
      let stack2 = stack1
      stack1.pop()
      XCTAssertNotEqual(stack1.hashValue, stack2.hashValue)
    }
  }
  
  static var allTests = [
    ("test_stack", test_stack),
    ("test_comparable", test_comparable),
    ("test_hashable", test_hashable),
  ]
  
}
