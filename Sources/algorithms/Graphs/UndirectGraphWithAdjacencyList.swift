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

//MARK: - DFS

extension UndirectGraphWithAdjacencyList {
  
  public class DFSContext {
    public var onVisitNode: ((Node<Element>) -> Void)?
    public var didVisitNode: ((Node<Element>) -> Void)?
    public var onVisitChild: ((Node<Element>, Node<Element>) -> Void)?
    public var onVisitNewRoot: ((Node<Element>) -> Void)?
    
    public init() {}
  }
  
  public func makeDFSContext() -> DFSContext {
    DFSContext()
  }
  
  /// - Complexity: O(V + E)
  public func dfs(contex: DFSContext, root: Node<Element>? = nil) {
    var visited = [Bool](repeating: false, count: nodes.count)
    
    func dfs(node: Node<Element>) {
      visited[node.index] = true
      contex.onVisitNode?(node)
      for child in node.adjacencyList where !visited[child.index] {
        contex.onVisitChild?(node, child)
        dfs(node: child)
      }
      contex.didVisitNode?(node)
    }
    
    for node in root != nil ? [root!] : nodes where !visited[node.index] {
      contex.onVisitNewRoot?(node)
      dfs(node: node)
    }
  }
  
  /// - Complexity: O(V + E)
  public func connectedComponents() -> Set<Set<Node<Element>>> {
    var connectedComponents = Set<Set<Node<Element>>>()
    var current = Set<Node<Element>>()
    
    let contex = DFSContext()
    contex.onVisitNode = { current.insert($0) }
    contex.onVisitNewRoot = { _ in
      if !current.isEmpty {
        connectedComponents.insert(current)
      }
      current = Set<Node<Element>>()
    }
    dfs(contex: contex)
    
    if !current.isEmpty {
      connectedComponents.insert(current)
    }
    
    return connectedComponents
  }
  
  /// Returns a dictionary where each key is a node its value is its parent
  /// - Complexity: O(V + E)
  public func dfsTree(root: Node<Element>?) -> [Node<Element> : Node<Element>] {
    var parents = [Node<Element> : Node<Element>]()
    
    let contex = DFSContext()
    contex.onVisitChild = {parent, node in parents[node] = parent }
    
    dfs(contex: contex, root: root)
    return parents
  }
  
}
