import XCTest
@testable import algorithms

final class QueueTests: XCTestCase {
  
  func test_queue() {
    var queue = Queue<Int>()
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
  
  func test_equatable() {
    do {
      var queue = Queue<Int>()
      queue.enqueue(1)
      queue.enqueue(2)
      XCTAssertEqual(queue, queue)
    }
    
    do {
      var queue = Queue<Int>()
      queue.enqueue(1)
      queue.enqueue(2)
      var queue2 = queue
      queue2.dequeue()
      XCTAssertNotEqual(queue, queue2)
    }
  }
  
  func test_hashable() {
    var queue = Queue<Int>()
    queue.enqueue(1)
    queue.enqueue(2)
    XCTAssertEqual(queue.hashValue, queue.hashValue)
  }
  
  static var allTests = [
    ("test_queue", test_queue),
    ("test_equatable", test_equatable),
    ("test_hashable", test_hashable),
  ]
  
}
