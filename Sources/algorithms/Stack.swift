import Foundation

public struct Stack<Element> {
  
  private var buffer = [Element]()
  
}

extension Stack {
  
  /// - Complexity: O(1)
  public var isEmpty: Bool {
    return buffer.isEmpty
  }
  
  /// - Complexity: O(1)
  @discardableResult
  public mutating func pop() -> Element? {
    return buffer.popLast() // constant amortized cost
  }
  
  /// - Complexity: O(1)
  public mutating func push(_ newElement: Element) {
    buffer.append(newElement) // constant amortized cost
  }
  
}
