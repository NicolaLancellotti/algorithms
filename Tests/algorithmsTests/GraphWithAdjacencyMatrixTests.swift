import XCTest
@testable import algorithms

final class GraphWithAdjacencyMatrixTests: XCTestCase {
  
  func testArches() {
    let nodeA = GraphWithAdjacencyMatrix.makeNode(info: "A")
    let nodeB = GraphWithAdjacencyMatrix.makeNode(info: "V")
    let graph = GraphWithAdjacencyMatrix(nodes: [nodeA, nodeB])
  
    XCTAssertFalse(graph[nodeA, nodeB])
    XCTAssertFalse(graph[nodeB, nodeA])
    
    graph[nodeA, nodeB] = true
    
    XCTAssertTrue(graph[nodeA, nodeB])
    XCTAssertFalse(graph[nodeB, nodeA])
  }
  
  static var allTests = [
    ("testArches", testArches),
  ]
  
}
