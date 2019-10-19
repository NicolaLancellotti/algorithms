import XCTest
@testable import algorithms

final class SortTests: XCTestCase {
  
  func test_selectionSort() {
    do {
      var collection:[Int] = []
      let sorted = collection.sorted()
      Sort.selectionSort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [1, 2, 3]
      let sorted = collection.sorted()
      Sort.selectionSort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [1, 3, 2]
      let sorted = collection.sorted()
      Sort.selectionSort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [2, 1, 3]
      let sorted = collection.sorted()
      Sort.selectionSort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [2, 3, 1]
      let sorted = collection.sorted()
      Sort.selectionSort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [3, 1, 2]
      let sorted = collection.sorted()
      Sort.selectionSort(&collection)
      XCTAssertEqual(collection, sorted)
    }
    
    do {
      var collection:[Int] = [3, 2, 1]
      let sorted = collection.sorted()
      Sort.selectionSort(&collection)
      XCTAssertEqual(collection, sorted)
    }
  }
  
  static var allTests = [
    ("test_selectionSort", test_selectionSort),
  ]
}
