import XCTest
import algorithms

final class GraphWithAdjacencyMatrixTests: XCTestCase {
  
  func test_arches() {
    let nodeA = GraphWithAdjacencyMatrix.makeNode(info: "A")
    let nodeB = GraphWithAdjacencyMatrix.makeNode(info: "B")
    let graph = GraphWithAdjacencyMatrix(nodes: [nodeA, nodeB])
    
    XCTAssertFalse(graph[nodeA, nodeB])
    XCTAssertFalse(graph[nodeB, nodeA])
    
    graph[nodeA, nodeB] = true
    
    XCTAssertTrue(graph[nodeA, nodeB])
    XCTAssertFalse(graph[nodeB, nodeA])
  }
  
  func test_universalSink_true() {
    let nodeA = GraphWithAdjacencyMatrix.makeNode(info: "A")
    let nodeB = GraphWithAdjacencyMatrix.makeNode(info: "B")
    let nodeC = GraphWithAdjacencyMatrix.makeNode(info: "C")
    
    let graph = GraphWithAdjacencyMatrix(nodes: [nodeA, nodeB, nodeC])
    
    //  A -> C <- B
    graph[nodeA, nodeC] = true
    graph[nodeB, nodeC] = true
    
    let universalSink = graph.universalSink!
    XCTAssertTrue(graph.isUniversalSink(node: universalSink))
    XCTAssertTrue(universalSink === nodeC)
  }
  
  func test_universalSink_false_1() {
    let nodeA = GraphWithAdjacencyMatrix.makeNode(info: "A")
    let nodeB = GraphWithAdjacencyMatrix.makeNode(info: "B")
    let nodeC = GraphWithAdjacencyMatrix.makeNode(info: "C")
    let graph = GraphWithAdjacencyMatrix(nodes: [nodeA, nodeB, nodeC])
    
    //  A -> C  B
    graph[nodeA, nodeC] = true
    
    let universalSink = graph.universalSink
    XCTAssertNil(universalSink)
  }
  
  func test_universalSink_false_2() {
    let nodeA = GraphWithAdjacencyMatrix.makeNode(info: "A")
    let nodeB = GraphWithAdjacencyMatrix.makeNode(info: "B")
    let nodeC = GraphWithAdjacencyMatrix.makeNode(info: "C")
    let graph = GraphWithAdjacencyMatrix(nodes: [nodeA, nodeB, nodeC])
    
    //  A <-> C <- B
    graph[nodeA, nodeC] = true
    graph[nodeB, nodeC] = true
    graph[nodeC, nodeA] = true
    
    let universalSink = graph.universalSink
    XCTAssertNil(universalSink)
  }
  
  static var allTests = [
    ("test_arches", test_arches),
    ("test_universalSink_false_1", test_universalSink_false_1),
    ("test_universalSink_false_2", test_universalSink_false_2),
  ]
  
}
