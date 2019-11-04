import Foundation

public struct StackUsingList<Element> {
  
  private var list = SinglyLinkedList<Element>()
  
}

extension StackUsingList {
  
  /// - Complexity: O(1)
  public var isEmpty: Bool {
    list.isEmpty
  }
  
  /// - Complexity: O(1)
  @discardableResult
  public mutating func pop() -> Element? {
    list.isEmpty ? nil : list.removeFirst()
  }
  
  /// - Complexity: O(1)
  public mutating func push(_ newElement: Element) {
    list.insert(newElement, at: list.startIndex)
  }
  
}

extension StackUsingList: Equatable where Element: Equatable {
  
}

extension StackUsingList: Hashable where Element: Hashable {
  
}
