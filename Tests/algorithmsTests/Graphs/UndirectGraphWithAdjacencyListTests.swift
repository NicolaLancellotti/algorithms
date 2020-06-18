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
  
  func test_dfs() {
    let nodeA = UndirectGraphWithAdjacencyList.makeNode(info: "A")
    let nodeB = UndirectGraphWithAdjacencyList.makeNode(info: "B")
    let nodeC = UndirectGraphWithAdjacencyList.makeNode(info: "C")
    let nodeD = UndirectGraphWithAdjacencyList.makeNode(info: "D")
    let nodeE = UndirectGraphWithAdjacencyList.makeNode(info: "E")
    let graph = UndirectGraphWithAdjacencyList(nodes: [nodeA, nodeB, nodeC, nodeD, nodeE])!
    
    /*
     D - B - C
         |
         A
     E
     */
    graph[nodeA, nodeB] = true
    graph[nodeB, nodeC] = true
    graph[nodeB, nodeD] = true
    
    do {
      var visited = [UndirectGraphWithAdjacencyList<String>.Node<String>]()
      let contex = graph.makeDFSContext()
      contex.onVisitNode = { visited.append($0) }
      graph.dfs(contex: contex, root: nodeA)
      XCTAssertEqual(visited, [nodeA, nodeB, nodeC, nodeD])
    }
    
    do {
      var visited = [UndirectGraphWithAdjacencyList<String>.Node<String>]()
      let contex = graph.makeDFSContext()
      contex.onVisitNode = { visited.append($0) }
      graph.dfs(contex: contex)
      XCTAssertEqual(visited, [nodeA, nodeB, nodeC, nodeD, nodeE])
    }
  }
  
  func test_connectedComponents() {
    let nodeA = UndirectGraphWithAdjacencyList.makeNode(info: "A")
    let nodeB = UndirectGraphWithAdjacencyList.makeNode(info: "B")
    let nodeC = UndirectGraphWithAdjacencyList.makeNode(info: "C")
    let graph = UndirectGraphWithAdjacencyList(nodes: [nodeA, nodeB, nodeC])!
    
    graph[nodeA, nodeB] = true
    
    let connectedComponents = graph.connectedComponents()
    let set = Set([
      Set([nodeA, nodeB]),
      Set([nodeC])
    ])
    XCTAssertEqual(connectedComponents, set)
  }
  
  func test_dfsTree() {
    let nodeA = UndirectGraphWithAdjacencyList.makeNode(info: "A")
    let nodeB = UndirectGraphWithAdjacencyList.makeNode(info: "B")
    let nodeC = UndirectGraphWithAdjacencyList.makeNode(info: "C")
    let graph = UndirectGraphWithAdjacencyList(nodes: [nodeA, nodeB, nodeC])!
    
    graph[nodeA, nodeB] = true
    
    let dfsTree = graph.dfsTree(root: nodeA)
    XCTAssertNil(dfsTree[nodeA])
    XCTAssertEqual(dfsTree[nodeB], nodeA)
    XCTAssertNil(dfsTree[nodeC])
  }
  
  static var allTests = [
    ("test_arches", test_arches),
    ("test_dfs", test_dfs),
    ("test_init_graph", test_init_graph),
    ("test_connectedComponents", test_connectedComponents),
    ("test_dfsTree", test_dfsTree),
  ]
  
}
