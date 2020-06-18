import Foundation

public class GraphWithAdjacencyMatrix<Element> {
  
  public private(set) var nodes = [Node<Element>]()
  private var adjacencyMatrix: Matrix<Bool>
  
  public init(nodes: [Node<Element>]) {
    let count = nodes.count
    nodes.enumerated().forEach { $1.index = $0 }
    adjacencyMatrix = Matrix(rows: count, columns: count, repeating: false)
  }
  
}

extension GraphWithAdjacencyMatrix {
  
  public class Node<Element> {
    
    public var info: Element
    fileprivate var index: Int = 0
    
    fileprivate init(info: Element) {
      self.info = info
    }
    
  }
  
  public static func makeNode(info: Element) -> Node<Element> {
    Node(info: info)
  }
  
}

extension GraphWithAdjacencyMatrix {
  
  /// The setter sets if there is  an arch from `nodeA` to `nodeB`
  /// The getter returns `true` if there is an arch from `nodeA` to `nodeB`, `false` otherwise.
  /// - Complexity: O(1)
  public subscript(nodeA: Node<Element>, nodeB: Node<Element>) -> Bool {
    get { adjacencyMatrix[nodeA.index, nodeB.index] }
    set { adjacencyMatrix[nodeA.index, nodeB.index] = newValue }
  }
  
}
