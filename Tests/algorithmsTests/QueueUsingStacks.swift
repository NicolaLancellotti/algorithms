import XCTest
@testable import algorithms

final class QueueUsingStacksTests: XCTestCase {
  
  func test_fixedLengthQueue() {
    var queue = QueueUsingStacks<Int>()
    XCTAssertTrue(queue.isEmpty)
    
    XCTAssertNil(queue.dequeue())
    
    queue.enqueue(1)
    XCTAssertFalse(queue.isEmpty)
    
    queue.enqueue(2)
    XCTAssertFalse(queue.isEmpty)
    
    queue.enqueue(3)
    XCTAssertFalse(queue.isEmpty)
    
    XCTAssertEqual(queue.dequeue(), 1)
    XCTAssertFalse(queue.isEmpty)
    
    XCTAssertEqual(queue.dequeue(), 2)
    XCTAssertFalse(queue.isEmpty)
    
    queue.enqueue(4)
    XCTAssertFalse(queue.isEmpty)
    
    XCTAssertEqual(queue.dequeue(), 3)
    XCTAssertFalse(queue.isEmpty)
    
    XCTAssertEqual(queue.dequeue(), 4)
    XCTAssertTrue(queue.isEmpty)
    
    XCTAssertNil(queue.dequeue())
    XCTAssertTrue(queue.isEmpty)
  }
  
  static var allTests = [
    ("test_fixedLengthQueue", test_fixedLengthQueue),
  ]
  
}
