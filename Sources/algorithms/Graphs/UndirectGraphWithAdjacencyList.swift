import Foundation

public class UndirectGraphWithAdjacencyList<Element> {
  
  public private(set) var nodes = [Node<Element>]()
  
  public init?(nodes: [Node<Element>], checkNodes: Bool = false) {
    self.nodes = nodes
    if checkNodes {
      for node in nodes where node.index != -1{
        return nil
      }
    }
    nodes.enumerated().forEach { $1.index = $0 }
  }
  
}

extension UndirectGraphWithAdjacencyList {
  
  public class Node<Element>: Hashable {
    
    fileprivate var index: Int = -1
    fileprivate var adjacencyList = [Node]()
    public var info: Element
    
    fileprivate init(info: Element) {
      self.info = info
    }
    
    fileprivate func isAdjacent(_ node: Node) -> Bool {
      adjacencyList.contains(where: { $0 === node})
    }
    
    @discardableResult
    fileprivate func removeAdjacent(_ node: Node) -> Bool {
      if let index = adjacencyList.firstIndex(where: {$0 === node})  {
        adjacencyList.remove(at: index)
        return true
      } else {
        return false
      }
    }
    
    fileprivate func addAdjacent(_ node: Node) {
      adjacencyList.append(node)
    }
    
    public static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
      lhs === rhs
    }
    
    public func hash(into hasher: inout Hasher) {
      hasher.combine(ObjectIdentifier(self))
    }
  
  }
  
  public static func makeNode(info: Element) -> Node<Element> {
    Node(info: info)
  }
  
}

extension UndirectGraphWithAdjacencyList {
  
  /// The setter sets if there is  an arch between `nodeA` and `nodeB`
  /// The getter returns `true` if there is an arch between `nodeA` and `nodeB`, `false` otherwise.
  /// - Complexity: O(E)
  public subscript(nodeA: Node<Element>, nodeB: Node<Element>) -> Bool {
    get {
      nodeA.isAdjacent(nodeB)
    }
    set {
      switch newValue {
        case true:
          guard !nodeA.isAdjacent(nodeB) else  { return }
          nodeA.addAdjacent(nodeB)
          nodeB.addAdjacent(nodeA)
        case false:
          if nodeA.removeAdjacent(nodeB) {
            nodeB.removeAdjacent(nodeA)
        }
      }
    }
  }
  
}
