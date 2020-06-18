import Foundation

public class DirectGraphWithAdjacencyMatrix<Element> {
  
  public private(set) var nodes: [Node<Element>]
  private var adjacencyMatrix: Matrix<Bool>
  
  /// Returns nil if a node in nodes has already been added to another graph
  public init?(nodes: [Node<Element>], checkNodes: Bool = false) {
    self.nodes = nodes
    let count = nodes.count
    if checkNodes {
      for node in nodes where node.index != -1{
        return nil
      }
    }
    nodes.enumerated().forEach { $1.index = $0 }
    adjacencyMatrix = Matrix(rows: count, columns: count, repeating: false)
  }
  
}

extension DirectGraphWithAdjacencyMatrix {
  
  public class Node<Element> {
    
    public var info: Element
    fileprivate var index: Int = -1
    
    fileprivate init(info: Element) {
      self.info = info
    }
    
  }
  
  public static func makeNode(info: Element) -> Node<Element> {
    Node(info: info)
  }
  
}


extension DirectGraphWithAdjacencyMatrix {
  
  /// The setter sets if there is  an arch from `nodeA` to `nodeB`
  /// The getter returns `true` if there is an arch from `nodeA` to `nodeB`, `false` otherwise.
  /// - Complexity: O(1)
  public subscript(nodeA: Node<Element>, nodeB: Node<Element>) -> Bool {
    get { adjacencyMatrix[nodeA.index, nodeB.index] }
    set { adjacencyMatrix[nodeA.index, nodeB.index] = newValue }
  }
  
}

//MARK: - Universal sink

extension DirectGraphWithAdjacencyMatrix {
  
  ///  A sink, in a directed graph, is a vertex with out-degree equals 0 and in-degree  equals V - 1.
  /// - Complexity: O(V)
  public func isUniversalSink(node: Node<Element>) -> Bool {
    let index = node.index
    for i in 0..<adjacencyMatrix.columns where i != index {
      if adjacencyMatrix[index, i] || !adjacencyMatrix[i, index] {
        return false
      }
    }
    return true
  }
  
  /// - Complexity: O(V)
  public var universalSink: Node<Element>? {
    var index = 0
    for i in stride(from: 1, to: adjacencyMatrix.columns, by: 1) {
      // adjacencyMatrix[index, i] == true  -> node at `index` is not an universal sink
      // adjacencyMatrix[index, i] == false -> node at `i` is not an universal sink
      if adjacencyMatrix[index, i] {
        index = i
      }
    }
    let node = nodes[index]
    return isUniversalSink(node: node) ? node : nil
  }
  
}
