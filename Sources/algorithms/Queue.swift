import Foundation

public struct Queue<Element> {
  
  private var list = SinglyLinkedList<Element>()
  
  public init() {}
}

extension Queue {
  
  /// - Complexity: O(1)
  public var isEmpty: Bool {
    list.isEmpty
  }
  
  /// - Complexity: O(1)
  @discardableResult
  public mutating func dequeue() -> Element? {
    list.isEmpty ? nil : list.removeFirst() 
  }
  
  /// - Complexity: O(1)
  public mutating func enqueue(_ newElement: Element) {
    list.append(newElement)
  }
  
}

extension Queue: Equatable where Element: Equatable {
  
}

extension Queue: Hashable where Element: Hashable {
  
}

