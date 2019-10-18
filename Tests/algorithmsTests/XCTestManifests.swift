import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(templateTests.allTests),
    testCase(MatrixTests.allTests),
    testCase(fibonacciTests.allTests),
  ]
}
#endif
