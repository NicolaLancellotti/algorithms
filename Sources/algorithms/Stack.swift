import Foundation

public struct Stack<Element> {
  
  private var buffer = [Element]()
  
  public init() {}
  
}

extension Stack {
  
  /// - Complexity: O(1)
  public var isEmpty: Bool {
    buffer.isEmpty
  }
  
  /// - Complexity: O(1)
  @discardableResult
  public mutating func pop() -> Element? {
    buffer.popLast() // constant amortized cost
  }
  
  /// - Complexity: O(1)
  public mutating func push(_ newElement: Element) {
    buffer.append(newElement) // constant amortized cost
  }
  
}

extension Stack: Equatable where Element: Equatable {
  
}

extension Stack: Hashable where Element: Hashable {
  
}
