import Foundation

public struct FixedLengthArray<Element> {
  
  private var _buf: Buffer<Element>
  
}

extension FixedLengthArray {
  
  public init(repeating repeatedValue: Element, count: Int) {
    let sequence = repeatElement(repeatedValue, count: count)
    _buf = Buffer(sequence: sequence, count: count)
  }
  
}

extension FixedLengthArray: ExpressibleByArrayLiteral {
  
  public init(arrayLiteral elements: Element...) {
    _buf = Buffer(sequence: elements, count: elements.count)
  }
  
}

extension FixedLengthArray: Collection, MutableCollection {
  
  /// - Complexity: O(1)
  public var startIndex: Int {
    _buf.buffer.startIndex
  }
  
  /// - Complexity: O(1)
  public var endIndex: Int {
    _buf.buffer.endIndex
  }
  
  /// - Complexity: O(1)
  public func index(after i: Int) -> Int {
    _buf.buffer.index(after: i)
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

extension FixedLengthArray: BidirectionalCollection {
  
  /// - Complexity: O(1)
  public func index(before i: Int) -> Int {
    _buf.buffer.index(before: i)
  }
  
}

extension FixedLengthArray: RandomAccessCollection {
  
}

extension FixedLengthArray: Equatable where Element: Equatable {
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    
    for (l, r) in zip(lhs._buf.buffer, rhs._buf.buffer) where l != r   {
      return false
    }
    return true
  }
  
}

extension FixedLengthArray: Hashable where Element: Hashable {
  
  public func hash(into hasher: inout Hasher) {
    for elem in self._buf.buffer {
      hasher.combine(elem)
    }
  }
  
}

extension FixedLengthArray: Comparable where Element: Comparable {
  
  public static func < (lhs: FixedLengthArray<Element>, rhs: FixedLengthArray<Element>) -> Bool {
    lhs._buf.buffer.lexicographicallyPrecedes(rhs._buf.buffer)
  }
  
}

private extension FixedLengthArray {
  
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
