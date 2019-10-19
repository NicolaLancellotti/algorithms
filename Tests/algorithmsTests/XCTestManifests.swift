import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(templateTests.allTests),
    testCase(SearchTests.allTests),
    testCase(SortTests.allTests),
    testCase(fibonacciTests.allTests),
    testCase(MatrixTests.allTests),
  ]
}
#endif
