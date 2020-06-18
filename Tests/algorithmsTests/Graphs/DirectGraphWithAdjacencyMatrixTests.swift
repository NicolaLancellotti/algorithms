import XCTest
import algorithms

final class DirectGraphWithAdjacencyMatrixTests: XCTestCase {
  
  func test_arches() {
    let nodeA = DirectGraphWithAdjacencyMatrix.makeNode(info: "A")
    let nodeB = DirectGraphWithAdjacencyMatrix.makeNode(info: "B")
    let graph = DirectGraphWithAdjacencyMatrix(nodes: [nodeA, nodeB])!
    
    XCTAssertFalse(graph[nodeA, nodeB])
    XCTAssertFalse(graph[nodeB, nodeA])
    
    graph[nodeA, nodeB] = true
    
    XCTAssertTrue(graph[nodeA, nodeB])
    XCTAssertFalse(graph[nodeB, nodeA])
    
    graph[nodeA, nodeB] = false
    
    XCTAssertFalse(graph[nodeA, nodeB])
    XCTAssertFalse(graph[nodeB, nodeA])
  }
  
  func test_init_graph() {
    let nodeA = DirectGraphWithAdjacencyMatrix.makeNode(info: "A")
    let _ = DirectGraphWithAdjacencyMatrix(nodes: [nodeA])
    let graph = DirectGraphWithAdjacencyMatrix(nodes: [nodeA], checkNodes: true)
    XCTAssertNil(graph)
  }
  
  func test_universalSink_true() {
    let nodeA = DirectGraphWithAdjacencyMatrix.makeNode(info: "A")
    let nodeB = DirectGraphWithAdjacencyMatrix.makeNode(info: "B")
    let nodeC = DirectGraphWithAdjacencyMatrix.makeNode(info: "C")
    
    let graph = DirectGraphWithAdjacencyMatrix(nodes: [nodeA, nodeB, nodeC])!
    
    //  A -> C <- B
    graph[nodeA, nodeC] = true
    graph[nodeB, nodeC] = true
    
    let universalSink = graph.universalSink!
    XCTAssertTrue(graph.isUniversalSink(node: universalSink))
    XCTAssertTrue(universalSink === nodeC)
  }
  
  func test_universalSink_false_1() {
    let nodeA = DirectGraphWithAdjacencyMatrix.makeNode(info: "A")
    let nodeB = DirectGraphWithAdjacencyMatrix.makeNode(info: "B")
    let nodeC = DirectGraphWithAdjacencyMatrix.makeNode(info: "C")
    let graph = DirectGraphWithAdjacencyMatrix(nodes: [nodeA, nodeB, nodeC])!
    
    //  A -> C  B
    graph[nodeA, nodeC] = true
    
    let universalSink = graph.universalSink
    XCTAssertNil(universalSink)
  }
  
  func test_universalSink_false_2() {
    let nodeA = DirectGraphWithAdjacencyMatrix.makeNode(info: "A")
    let nodeB = DirectGraphWithAdjacencyMatrix.makeNode(info: "B")
    let nodeC = DirectGraphWithAdjacencyMatrix.makeNode(info: "C")
    let graph = DirectGraphWithAdjacencyMatrix(nodes: [nodeA, nodeB, nodeC])!
    
    //  A <-> C <- B
    graph[nodeA, nodeC] = true
    graph[nodeB, nodeC] = true
    graph[nodeC, nodeA] = true
    
    let universalSink = graph.universalSink
    XCTAssertNil(universalSink)
  }
  
  static var allTests = [
    ("test_arches", test_arches),
    ("test_init_graph", test_init_graph),
    ("test_universalSink_false_1", test_universalSink_false_1),
    ("test_universalSink_false_2", test_universalSink_false_2),
  ]
  
}
