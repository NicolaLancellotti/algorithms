import XCTest
@testable import algorithms

final class MatrixTests: XCTestCase {
  
  func testInit() {
    let matrix = Matrix(rows: 2, columns: 2, repeating: 1)
    XCTAssertEqual(matrix[0, 0], 1)
    XCTAssertEqual(matrix[0, 1], 1)
    XCTAssertEqual(matrix[1, 0], 1)
    XCTAssertEqual(matrix[1, 1], 1)
  }
  
  func testInitWithColumns() {
    let matrix = Matrix(columns: 2, values: 1, 2, 3, 4)
    XCTAssertEqual(matrix[0, 0], 1)
    XCTAssertEqual(matrix[0, 1], 2)
    XCTAssertEqual(matrix[1, 0], 3)
    XCTAssertEqual(matrix[1, 1], 4)
  }
  
  func testIsSquare() {
    XCTAssertTrue(Matrix(rows: 2, columns: 2, repeating: 1).isSquare)
    XCTAssertFalse(Matrix(rows: 2, columns: 3, repeating: 1).isSquare)
    XCTAssertFalse(Matrix(rows: 2, columns: 3, repeating: 1).isSquare)
  }
  
  func testMakeIdentity() {
    let matrix = Matrix<Int>.makeIdentity(2)
    XCTAssertEqual(matrix, Matrix(columns: 2, values: 1, 0, 0, 1))
    XCTAssertNotEqual(matrix, Matrix(columns: 2, values: 1, 1, 1, 1))
  }
  
  func testProduct() {
    let matrix1 = Matrix<Int>(columns: 2, values: 1, 2, 3, 4)
    let matrixResult1 = Matrix<Int>(columns: 2, values: 7, 10, 15, 22)
    XCTAssertEqual(matrix1 * matrix1, matrixResult1)
    
    let matrix2 = Matrix<Int>(columns: 3, values: 1, 2, 3, 4, 5, 6)
    let matrixResult2 = Matrix<Int>(columns: 3, values: 9, 12, 15, 19, 26, 33)
    XCTAssertEqual(matrix1 * matrix2, matrixResult2)
  }
  
  func testPower() {
    let matrix = Matrix(columns: 2, values: 1, 2, 3, 4)
    XCTAssertEqual(matrix.power(0), Matrix.makeIdentity(2))
    XCTAssertEqual(matrix.power(1), matrix)
    XCTAssertEqual(matrix.power(2), matrix * matrix)
    XCTAssertEqual(matrix.power(3), matrix * matrix * matrix)
  }
  
  static var allTests = [
    ("testInit", testInit),
    ("testInitWithColumns", testInitWithColumns),
    ("testIsSquare", testIsSquare),
    ("testMakeIdentity", testMakeIdentity),
    ("testProduct", testProduct),
    ("testPower", testPower),
  ]
  
}
