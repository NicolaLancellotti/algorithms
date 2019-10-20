import XCTest
@testable import algorithms

final class SortTests: XCTestCase {
  
  func test_selectionSort() {
    test_common { collection in
      Sort.selectionSort(&collection)
    }
  }
  
  func test_insertionSort() {
    test_common { collection in
      Sort.insertionSort(&collection)
    }
  }
  
  func test_bubbleSort() {
    test_common { collection in
      Sort.bubbleSort(&collection)
    }
  }
  
  func test_heapSort() {
    test_common { collection in
      Sort.heapSort(&collection)
    }
  }
  
  func test_common(sort: (inout [Int]) -> Void) {
    do {
      var collection:[Int] = []
      let sorted = collection.sorted()
      sort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [1, 2, 3]
      let sorted = collection.sorted()
      sort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [1, 3, 2]
      let sorted = collection.sorted()
      sort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [2, 1, 3]
      let sorted = collection.sorted()
      sort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [2, 3, 1]
      let sorted = collection.sorted()
      sort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [3, 1, 2]
      let sorted = collection.sorted()
      sort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [3, 2, 1]
      let sorted = collection.sorted()
      sort(&collection)
      XCTAssertEqual(collection, sorted)
    }
  }
  
  static var allTests = [
    ("test_selectionSort", test_selectionSort),
    ("test_insertionSort", test_insertionSort),
    ("test_bubbleSort", test_bubbleSort),
    ("test_heapSort", test_heapSort),
  ]
}
