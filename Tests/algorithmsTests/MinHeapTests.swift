import XCTest
@testable import algorithms

final class MinHeapTests: XCTestCase {
  
  func test_makeWithInit() {
    var heap = makeHeapWithInit()
    shared_testMin(heap: &heap)
  }
  
  func test_makeWithInsert() {
    var heap = makeHeapWithInsert()
    shared_testMin(heap: &heap)
  }
  
  func test_makeWithMerge() {
    var heap = makeHeapWithMerge()
    shared_testMin(heap: &heap)
  }
  
  func test_firstIndex() {
    let heap = makeHeapWithInit()
    
    var index: Int?
    index = heap.firstIndex { key, value in key == 1 }
    XCTAssertEqual(heap[index!], "a")
    
    index = heap.firstIndex { key, value in key == 2 }
    XCTAssertEqual(heap[index!], "b")
    
    index = heap.firstIndex { key, value in key == 3 }
    XCTAssertEqual(heap[index!], "c")
    
    index = heap.firstIndex { key, value in key == 4 }
    XCTAssertEqual(heap[index!], "d")
    
    index = heap.firstIndex { key, value in key == 5 }
    XCTAssertEqual(heap[index!], "e")
    
    index = heap.firstIndex { key, value in key == -1 }
    XCTAssertNil(index)
  }
  
  func test_remove() {
    var heap = makeHeapWithInit()
    
    do {
      let index = heap.firstIndex { key, value in key == 1 }!
      let elem = heap.remove(at: index)
      XCTAssertEqual(elem, "a")
    }
    
    do {
      let index = heap.firstIndex { key, value in key == 5 }!
      let elem = heap.remove(at: index)
      XCTAssertEqual(elem, "e")
    }
    
    do {
      let index = heap.firstIndex { key, value in key == 2 }!
      let elem = heap.remove(at: index)
      XCTAssertEqual(elem, "b")
    }
    
    XCTAssertEqual(heap.count, 2)
    
    XCTAssertEqual(heap.min, "c")
    XCTAssertEqual(heap.popMin(), "c")
    XCTAssertEqual(heap.count, 1)
    
    XCTAssertEqual(heap.min, "d")
    XCTAssertEqual(heap.popMin(), "d")
    XCTAssertEqual(heap.count, 0)
    
    XCTAssertNil(heap.min)
    XCTAssertEqual(heap.count, 0)
  }
  
  func test_changeKey() {
    var heap = makeHeapWithInit()
    let index = heap.firstIndex { key, value in key == 5 }!
    heap.changeKeyForElement(at: index, to: -1)
    
    XCTAssertEqual(heap.min, "e")
    XCTAssertEqual(heap.popMin(), "e")
    XCTAssertEqual(heap.count, 4)
  }
  
  static var allTests = [
    ("test_makeWithInit", test_makeWithInit),
    ("test_makeWithInsert", test_makeWithInsert),
    ("test_makeWithMerge", test_makeWithMerge),
    ("test_firstIndex", test_firstIndex),
    ("test_remove", test_remove),
    ("test_changeKey", test_changeKey),
  ]
}

extension MinHeapTests {
  
  func makeHeapWithInit() -> MinHeap<Int, String> {
    let heap: MinHeap = [
      (key: 5, elem: "e" ),
      (key: 2, elem: "b" ),
      (key: 1, elem: "a" ),
      (key: 4, elem: "d" ),
      (key: 3, elem: "c" )
    ]
    return heap
  }
  
  func makeHeapWithInsert() -> MinHeap<Int, String> {
    var heap = MinHeap<Int, String>()
    heap.insert(key: 5, elem: "e")
    heap.insert(key: 2, elem: "b")
    heap.insert(key: 1, elem: "a")
    heap.insert(key: 4, elem: "d")
    heap.insert(key: 3, elem: "c")
    return heap
  }
  
  func makeHeapWithMerge() -> MinHeap<Int, String> {
    var heap: MinHeap = [
      (key: 5, elem: "e" ),
      (key: 2, elem: "b" )
    ]
    
    let heap2: MinHeap = [
      (key: 4, elem: "d" ),
      (key: 3, elem: "c" )
    ]
    
    heap.merge(with: heap2)
    heap.insert(key: 1, elem: "a")
    return heap
  }
  
  func shared_testMin(heap: inout MinHeap<Int, String>) {
    XCTAssertEqual(heap.count, 5)
    
    XCTAssertEqual(heap.min, "a")
    XCTAssertEqual(heap.popMin(), "a")
    XCTAssertEqual(heap.count, 4)
    
    XCTAssertEqual(heap.min, "b")
    XCTAssertEqual(heap.popMin(), "b")
    XCTAssertEqual(heap.count, 3)
    
    XCTAssertEqual(heap.min, "c")
    XCTAssertEqual(heap.popMin(), "c")
    XCTAssertEqual(heap.count, 2)
    
    XCTAssertEqual(heap.min, "d")
    XCTAssertEqual(heap.popMin(), "d")
    XCTAssertEqual(heap.count, 1)
    
    XCTAssertEqual(heap.min, "e")
    XCTAssertEqual(heap.popMin(), "e")
    XCTAssertEqual(heap.count, 0)
    
    XCTAssertNil(heap.min)
    XCTAssertEqual(heap.count, 0)
  }
  
}
