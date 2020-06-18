import Foundation

public struct MinHeap<Key, Element> where Key: Comparable {
  
  private var buffer: [(key: Key, elem: Element)]
  
}

extension MinHeap: ExpressibleByArrayLiteral {
  
  /// - Complexity: O(n)
  public init(arrayLiteral elements: (Key, Element)...) {
    self.buffer = elements
    build()
  }
  
}

extension MinHeap {
  
  /// - Complexity: O(1)
  public var count: Int {
    buffer.count
  }
  
  /// - Complexity: O(1)
  public var min: Element? {
    buffer.first?.elem
  }
  
  /// - Complexity: O(n)
  public func firstIndex(where predicate: (_ key: Key, _ elem: Element) throws -> Bool) rethrows -> Int? {
    try buffer.firstIndex(where: predicate)
  }
  
  /// - Complexity: O(lon(n))
  public mutating func insert(key: Key, elem: Element) {
    buffer.append((key, elem))
    moveUp(index: buffer.count - 1)
  }
  
  /// - Complexity: O(n + m) where n = self.count, m = minHeap.count
  public mutating func merge(with minHeap: MinHeap) {
    buffer.append(contentsOf: minHeap.buffer)
    build()
  }
  
  /// - Complexity: O(lon(n))
  mutating public func remove(at index: Int) -> Element {
    precondition(index >= buffer.startIndex && index < buffer.endIndex, "TODO")
    
    let value = buffer[index].elem
    let last = buffer.popLast()!
    
    if index != buffer.endIndex {
      buffer[index] = last
      moveUp(index: index)
      moveDown(index: index)
    }
    
    return value
  }
  
  /// - Complexity: O(lon(n))
  public mutating func popMin() -> Element? {
    buffer.isEmpty ? nil : remove(at: 0)
  }
  
  /// - Complexity: O(lon(n))
  public mutating func changeKeyForElement(at index: Int, to key: Key) {
    precondition(index >= buffer.startIndex && index < buffer.endIndex, "TODO")
    guard buffer[index].key != key else {
      return
    }
    let increased = buffer[index].key < key
    buffer[index].key = key
    increased ? moveDown(index: index) : moveUp(index: index)
  }
  
  public subscript(index: Int) -> Element {
    buffer[index].elem
   }
  
}

private extension MinHeap {
  
  /// - Complexity: O(n)
  private mutating func build() {
    for index in stride(from: buffer.count / 2 - 1, through: 0, by: -1) {
      moveDown(index: index)
    }
  }
  
  /// - Complexity: O(log(n))
  private mutating func moveDown(index: Int) {
    var current = index
    while true {
      let left = leftChild(of: current)
      let right = rightChild(of: current)
      var minIndex = left < buffer.count && buffer[left].key < buffer[current].key
        ? left : current
      if right < buffer.count && buffer[right].key < buffer[minIndex].key {
        minIndex = right
      }
      
      if minIndex != current {
        buffer.swapAt(current, minIndex)
        current = minIndex
      } else {
        break
      }
    }
  }
  
  /// - Complexity: O(log(n))
  private mutating func moveUp(index: Int) {
    var current = index
    while current > 0 {
      let p = parent(of: current)
      if buffer[current].key < buffer[p].key {
        buffer.swapAt(p, current)
        current = p
      } else {
        break
      }
    }
  }
  
  private func leftChild(of index: Int) -> Int {
    index << 1 + 1 // index * 2 + 1
  }
  
  private func rightChild(of index: Int) -> Int {
    index << 1 + 2 // index * 2 + 2
  }
  
  private func parent(of index: Int) -> Int {
    index >> 1 // index / 2
  }
  
}
