import Foundation

public struct FixedLeghtArray<Element> {
  
  private var _buf: Buffer<Element>
  
}

extension FixedLeghtArray {
  
  public init(repeating repeatedValue: Element, count: Int) {
    let sequence = repeatElement(repeatedValue, count: count)
    _buf = Buffer(sequence: sequence, count: count)
  }
  
}

extension FixedLeghtArray: ExpressibleByArrayLiteral {
  
  public init(arrayLiteral elements: Element...) {
    _buf = Buffer(sequence: elements, count: elements.count)
  }
  
}

extension FixedLeghtArray: Collection, MutableCollection {
  
  /// - Complexity: O(1)
  public var startIndex: Int {
    return _buf.buffer.startIndex
  }
  
  /// - Complexity: O(1)
  public var endIndex: Int {
    return _buf.buffer.endIndex
  }
  
  /// - Complexity: O(1)
  public func index(after i: Int) -> Int {
    return _buf.buffer.index(after: i)
  }
  
  /// - Complexity: O(1)
  public subscript(position: Int) -> Element {
    get {
      _buf.buffer[position]
    }
    set {
      if !isKnownUniquelyReferenced(&_buf) {
        _buf = _buf.copy()
      }
      _buf.buffer[position] = newValue
    }
  }
  
}

extension FixedLeghtArray: BidirectionalCollection {
  
  /// - Complexity: O(1)
  public func index(before i: Int) -> Int {
    return _buf.buffer.index(before: i)
  }
  
}

extension FixedLeghtArray: RandomAccessCollection {
  
}

private extension FixedLeghtArray {
  
  final class Buffer<Element> {
    
    let buffer: UnsafeMutableBufferPointer<Element>
    
    init<S>(sequence: S, count: Int) where S: Sequence, S.Element == Element {
      buffer = UnsafeMutableBufferPointer(start: .allocate(capacity: count),
                                          count: count)
      let (_, index) = buffer.initialize(from: sequence)
      assert(index == count)
    }
    
    func copy() -> Buffer<Element> {
      Buffer(sequence: buffer, count: buffer.count)
    }
    
    deinit {
      buffer.baseAddress?.deinitialize(count: buffer.count)
      buffer.deallocate()
    }
  }
  
}
