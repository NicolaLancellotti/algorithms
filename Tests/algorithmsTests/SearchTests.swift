import XCTest
@testable import algorithms

final class SearchTests: XCTestCase {
  
  func test_sequentialSearch_empty() {
    XCTAssertNil(Search.sequential(-1, in: []))
  }
  
  func test_sequentialSearch() {
    let sequence = [10, 2]
    
    XCTAssertNil(Search.sequential(-1, in: sequence))
    XCTAssertNil(Search.sequential(3, in: sequence))
    
    do {
      let elem = 10
      let result = Search.sequential(elem, in: sequence)
      XCTAssertEqual(result?.index, 0)
      XCTAssertEqual(result?.element, elem)
    }
    
    do {
      let elem = 2
      let result = Search.sequential(elem, in: sequence)
      XCTAssertEqual(result?.index, 1)
      XCTAssertEqual(result?.element, elem)
    }
  }
  
  func test_binarySearch_empty() {
    XCTAssertNil(Search.binary(-1, in: []))
  }
  
  func test_binarySearch() {
    let collection = ["a", "b", "c", "d"]
    
    XCTAssertNil(Search.binary("z", in: collection))
    XCTAssertNil(Search.binary("y", in: collection))

    do {
      let elem = "a"
      let result = Search.binary(elem, in: collection)
      XCTAssertEqual(result?.index, 0)
      XCTAssertEqual(result?.element, elem)
    }

    do {
      let elem = "b"
      let result = Search.binary(elem, in: collection)
      XCTAssertEqual(result?.index, 1)
      XCTAssertEqual(result?.element, elem)
    }

    do {
      let elem = "c"
      let result = Search.binary(elem, in: collection)
      XCTAssertEqual(result?.index, 2)
      XCTAssertEqual(result?.element, elem)
    }

    do {
      let elem = "d"
      let result = Search.binary(elem, in: collection)
      XCTAssertEqual(result?.index, 3)
      XCTAssertEqual(result?.element, elem)
    }
  }
  
  static var allTests = [
    ("test_sequentialSearch_empty", test_sequentialSearch_empty),
    ("test_binarySearch_empty", test_binarySearch_empty),
    ("test_binarySearch", test_binarySearch),
    ("test_binarySearch", test_binarySearch),
  ]
  
}
