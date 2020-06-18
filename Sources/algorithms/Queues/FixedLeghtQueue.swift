import Foundation

public struct FixedLengthQueue<Element> {
  
  private var buffer: FixedLengthArray<Element?>
  private var headIndex = 0
  private var tailIndex = 0
  private var count = 0
  
}

extension FixedLengthQueue {
  
  public init(count: Int) {
    precondition(count > 0, "count must be greater than 0")
    buffer = FixedLengthArray<Element?>(repeating: nil, count: count)
  }
  
}

extension FixedLengthQueue {
  
  public enum FixedLengthQueueError: Error {
    case full
  }
  
  /// - Complexity: Θ(1)
  public mutating func enqueue(_ newElement: Element) throws {
    if isFull {
      throw FixedLengthQueueError.full
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
    headIndex == tailIndex && count == 0
  }
  
  /// - Complexity: Θ(1)
  public var isFull: Bool {
    headIndex == tailIndex && count != 0
  }
  
}

extension FixedLengthQueue {
  
  private func nextIndex(_ index: Int) -> Int {
    (index + 1) % buffer.count
  }
  
}
