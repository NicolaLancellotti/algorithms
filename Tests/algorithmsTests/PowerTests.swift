import XCTest
@testable import algorithms

final class PowerTests: XCTestCase {
  
  func test_powerInteger() {
    var (base, esp): (Int8, UInt)
    
    (base, esp) = (2, 0)
    XCTAssertEqual(Math.power(base: base, exp: esp), 1)
    
    (base, esp) = (2, 1)
    XCTAssertEqual(Math.power(base: base, exp: esp), 2)
    
    (base, esp) = (2, 2)
    XCTAssertEqual(Math.power(base: base, exp: esp), 4)
    
    (base, esp) = (2, 3)
    XCTAssertEqual(Math.power(base: base, exp: esp), 8)
  }
  
  func test_powerFloat1() {
    var (base, esp): (Double, Int)
    
    (base, esp) = (2.0, 0)
    XCTAssertEqual(Math.power(base: base, exp: esp), 1)
    
    (base, esp) = (2.0, 1)
    XCTAssertEqual(Math.power(base: base, exp: esp), 2)
    
    (base, esp) = (2.0, -1)
    XCTAssertEqual(Math.power(base: base, exp: esp), 0.5)
    
    (base, esp) = (2.0, 2)
    XCTAssertEqual(Math.power(base: base, exp: esp), 4)
    
    (base, esp) = (2.0, -2)
    XCTAssertEqual(Math.power(base: base, exp: esp), 0.25)
    
    (base, esp) = (2.0, 3)
    XCTAssertEqual(Math.power(base: base, exp: esp), 8)
    
    (base, esp) = (2.0, -3)
    XCTAssertEqual(Math.power(base: base, exp: esp), 0.125)
  }
  
  func test_powerFloat2() {
    let accuracy = 0.000000001
    var (base, esp): (Double, Int)
    
    (base, esp) = (2.1, 0)
    XCTAssertEqual(Math.power(base: base, exp: esp), 1, accuracy: accuracy)
    
    (base, esp) = (2.1, 1)
    XCTAssertEqual(Math.power(base: base, exp: esp), 2.1, accuracy: accuracy)
    
    (base, esp) = (2.1, -1)
    XCTAssertEqual(Math.power(base: base, exp: esp), 0.476190476, accuracy: accuracy)
    
    (base, esp) = (2.1, 2)
    XCTAssertEqual(Math.power(base: base, exp: esp), 4.41, accuracy: accuracy)
    
    (base, esp) = (2.1, -2)
    XCTAssertEqual(Math.power(base: base, exp: esp), 0.22675737, accuracy: accuracy)
    
    (base, esp) = (2.1, 3)
    XCTAssertEqual(Math.power(base: base, exp: esp), 9.261, accuracy: accuracy)
    
    (base, esp) = (2.1, -3)
    XCTAssertEqual(Math.power(base: base, exp: esp), 0.1079797, accuracy: accuracy)
  }
  
  static var allTests = [
    ("test_powerInteger", test_powerInteger),
    ("test_powerFloat1", test_powerFloat1),
    ("test_powerFloat2", test_powerFloat2),
  ]
}
