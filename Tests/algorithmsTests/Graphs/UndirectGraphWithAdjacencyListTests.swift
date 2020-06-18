import XCTest
import algorithms

final class UndirectGraphWithAdjacencyListTests: XCTestCase {
  
  func test_arches() {
    let nodeA = UndirectGraphWithAdjacencyList.makeNode(info: "A")
    let nodeB = UndirectGraphWithAdjacencyList.makeNode(info: "B")
    let graph = UndirectGraphWithAdjacencyList(nodes: [nodeA, nodeB])!
    
    XCTAssertFalse(graph[nodeA, nodeB])
    XCTAssertFalse(graph[nodeB, nodeA])
    
    graph[nodeA, nodeB] = true
    
    XCTAssertTrue(graph[nodeA, nodeB])
    XCTAssertTrue(graph[nodeB, nodeA])
    
    graph[nodeB, nodeA] = false
    
    XCTAssertFalse(graph[nodeA, nodeB])
    XCTAssertFalse(graph[nodeB, nodeA])
  }
  
  func test_init_graph() {
    let nodeA = UndirectGraphWithAdjacencyList.makeNode(info: "A")
    let _ = UndirectGraphWithAdjacencyList(nodes: [nodeA])
    let graph = UndirectGraphWithAdjacencyList(nodes: [nodeA], checkNodes: true)
    XCTAssertNil(graph)
  }
  
  static var allTests = [
    ("test_arches", test_arches),
    ("test_init_graph", test_init_graph),
  ]
  
}
