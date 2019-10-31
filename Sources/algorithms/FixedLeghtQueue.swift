import Foundation

public struct FixedLeghtQueue<Element> {
  
  private var buffer: FixedLeghtArray<Element?>
  private var headIndex = 0
  private var tailIndex = 0
  private var count = 0
  
}

extension FixedLeghtQueue {
  
  init(count: Int) {
    precondition(count > 0, "count must be greater than 0")
    buffer = FixedLeghtArray<Element?>(repeating: nil, count: count)
  }
  
}

extension FixedLeghtQueue {
  
  public enum FixedLeghtQueueError: Error {
    case full
  }
  
  /// - Complexity: Θ(1)
  public mutating func enqueue(_ newElement: Element) throws {
    if isFull {
      throw FixedLeghtQueueError.full
    }
    count += 1
    buffer[tailIndex] = newElement
    tailIndex = nextIndex(tailIndex)
  }
  
  /// - Complexity: Θ(1)
  @discardableResult
  public mutating func dequeue() -> Element?  {
    if isEmpty {
      return nil
    }
    count -= 1
    defer {
      headIndex = nextIndex(headIndex)
    }
    return buffer[headIndex]!
  }
  
  /// - Complexity: Θ(1)
  public var isEmpty: Bool {
    return headIndex == tailIndex && count == 0
  }
  
  /// - Complexity: Θ(1)
  public var isFull: Bool {
    return headIndex == tailIndex && count != 0
  }
  
}

extension FixedLeghtQueue {
  
  private func nextIndex(_ index: Int) -> Int {
    return (index + 1) % buffer.count
  }
  
}
