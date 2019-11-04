import Foundation

public struct SinglyLinkedList<Element> {
  
  private var _buf = SinglyLinkedListRef<Element>()
  
  public init() { }
  
  mutating func _testUniquelyReferenced() {
    if !isKnownUniquelyReferenced(&_buf) {
      self = SinglyLinkedList(self)
    }
  }
  
}

extension SinglyLinkedList: Equatable where Element: Equatable {
  
  public static func == (lhs: SinglyLinkedList<Element>, rhs: SinglyLinkedList<Element>) -> Bool {
    if lhs.count != rhs.count {
      return false
    }
    
    for (l, r) in zip(lhs, rhs) where l != r   {
      return false
    }
    return true
  }
  
}

extension SinglyLinkedList: Hashable where Element: Hashable {
  
  public func hash(into hasher: inout Hasher) {
    for elem in self {
      hasher.combine(elem)
    }
  }
  
}

extension SinglyLinkedList: Comparable where Element: Comparable {
  
  public static func < (lhs: SinglyLinkedList<Element>, rhs: SinglyLinkedList<Element>) -> Bool {
    lhs.lexicographicallyPrecedes(rhs)
  }
  
}

extension SinglyLinkedList {
  
  public subscript(index: Int) -> Element {
    get {
      self[self.index(startIndex, offsetBy: index)]
    } set {
      _testUniquelyReferenced()
      self[self.index(startIndex, offsetBy: index)] = newValue
    }
  }
  
  /// - Complexity: O(1)
  public var last: Element? {
    _buf.last
  }
  
  /// - Complexity: O(n)
  mutating func reverse() {
    _testUniquelyReferenced()
    _buf.reverse()
  }
  
}

//MARK: Collection conformance

extension SinglyLinkedList {
  
  public struct Index: Comparable {
    
    fileprivate var node: SinglyLinkedListRef<Element>.NodePointer?
    fileprivate var index: Int
    
    public static func < (lhs: Index, rhs: Index) -> Bool {
      lhs.index < rhs.index
    }
    
  }
}

extension SinglyLinkedList: Collection, MutableCollection {
  
  public var startIndex: Index {
    _buf.isEmpty ? endIndex : Index(node: _buf.head, index: 0)
  }
  
  public var endIndex: Index {
    Index(node: nil, index: Int.max)
  }
  
  public func index(after i: Index) -> Index {
    let next = i.node?.pointee.next
    return next == nil ? endIndex: Index(node: next, index: i.index + 1)
  }
  
  public subscript(index: Index) -> Element {
    get {
      if let node = index.node {
        return node.pointee.info
      } else {
        fatalError("Index out of range")
      }
    } set {
      if let node = index.node {
        _testUniquelyReferenced()
        node.pointee.info = newValue
      } else {
        fatalError("Index out of range")
      }
    }
  }
  
}

extension SinglyLinkedList: RangeReplaceableCollection {
  
  public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C)
    where C : Collection, R : RangeExpression, Element == C.Element, Index == R.Bound {
     
      _testUniquelyReferenced()
      let range = subrange.relative(to: self)
      
      let lowerBoundIndex = range.lowerBound.index
      var previous = isEmpty || lowerBoundIndex == 0 ? nil : _buf.node(at: lowerBoundIndex - 1)
      
      var index = range.lowerBound
      while index < range.upperBound {
        _buf.remove(after: previous)
        self.formIndex(after: &index)
      }
      
      for elem in newElements {
        previous = _buf.insert(elem, after: previous)
      }
  }
  
  public mutating func append(_ newElement: Element) {
    _testUniquelyReferenced()
    _buf.insert(newElement, after: _buf.tail)
  }
  
}

//MARK: Singly Linked List Class

private class SinglyLinkedListRef<Element> {
  
  var head: NodePointer? = nil
  var tail: NodePointer? = nil
  
}

extension SinglyLinkedListRef {
  
  typealias NodePointer = UnsafeMutablePointer<Node>
  
  struct Node {
    var info: Element
    var next: UnsafeMutablePointer<Node>?
    
    static func make(info: Element, next: NodePointer?) -> NodePointer {
      let nodeP = NodePointer.allocate(capacity: 1)
      nodeP.initialize(to: Node(info: info, next: next))
      return nodeP
    }
    
    static func deinitializeAndDeallocate(_ node: NodePointer) {
      node.deinitialize(count: 1)
      node.deallocate()
    }
    
  }
  
  func node(at index: Int) -> NodePointer? {
    var iter = sequence(first: self.head) { $0?.pointee.next }
      .dropFirst(index).makeIterator()
    return iter.next()!
    
    //    var current = self.head
    //    for _ in 0..<index {
    //      if current == nil {
    //        return nil
    //      }
    //      current = current?.pointee.next
    //    }
    //    return current
  }
  
}

extension SinglyLinkedListRef {
  
  var isEmpty: Bool {
    head == nil
  }
  
  var last: Element? {
    tail?.pointee.info
  }
  
  /// If *previous* is nil adds the *newElement*  in the head , otherwise adds the *newElement* after *previous*
  @discardableResult
  func insert(_ newElement: Element, after previous: NodePointer?) -> NodePointer {
    switch previous {
      case .none:
        let newNode = Node.make(info: newElement, next: head)
        if self.isEmpty {
          tail = newNode
        }
        head = newNode
        return newNode
      case .some(let previous):
        let newNode =  Node.make(info: newElement, next: previous.pointee.next)
        previous.pointee.next = newNode
        if previous == tail {
          tail = newNode
        }
        return newNode
    }
  }
  
  /// If *previous* is nil removes the head node , otherwise removes the node after *previous*
  func remove(after previous: NodePointer?) {
    switch previous {
      case .none:
        let toRemove = self.head!
        self.head = toRemove.pointee.next
        if isEmpty {
          self.tail = nil
        }
        Node.deinitializeAndDeallocate(toRemove)
      case .some(let previous):
        let toRemove = previous.pointee.next!
        if toRemove == self.tail {
          self.tail = previous
        }
        previous.pointee.next = previous.pointee.next?.pointee.next
        Node.deinitializeAndDeallocate(toRemove)
    }
  }
  
  func reverse() {
    var newHead: NodePointer? = nil
    var current = self.head
    while let node = current {
      current = node.pointee.next
      node.pointee.next = newHead
      newHead = node
    }
    self.head = newHead
  }
  
}
