import Foundation

public enum Sort {}

//MARK: - Selection Sort

extension Sort {
  
  /// - Complexity: Θ(n^2)
  public static func selectionSort<C>(
    _ coll: inout C,
    by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool) rethrows where
    C: RandomAccessCollection,
    C: MutableCollection {
      
      func indexMinElement(from index: C.Index) throws -> C.Index{
        var index = index
        var current = coll.index(after: index)
        while current < coll.endIndex {
          if try areInIncreasingOrder(coll[current], coll[index]) {
            index = current
          }
          coll.formIndex(after: &current)
        }
        return index
      }
      
      var index = coll.startIndex
      while index < coll.index(before: coll.endIndex) {
        try coll.swapAt(index, indexMinElement(from: index))
        coll.formIndex(after: &index)
      }
  }
  
  /// - Complexity: Θ(n^2)
  public static func selectionSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable {
      selectionSort(&coll) { $0 < $1 }
  }
  
}

//MARK: - Sort

extension Sort {
  
  /// - Complexity: O(n^2), best case: Θ(n)
  public static func insertionSort<C>(
    _ coll: inout C,
    by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool) rethrows where
    C: RandomAccessCollection,
    C: MutableCollection {
      var index = coll.index(after: coll.startIndex)
      while index < coll.endIndex {
        let elem = coll[index]
        var current = coll.index(before: index)
        while try current >= coll.startIndex && areInIncreasingOrder(elem, coll[current]) {
          coll[coll.index(after: current)] = coll[current]
          coll.formIndex(before: &current)
        }
        coll[coll.index(after: current)] = elem
        coll.formIndex(after: &index)
      }
  }
  
  /// - Complexity: O(n^2), best case: Θ(n)
  public static func insertionSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable {
      insertionSort(&coll) { $0 < $1 }
  }
  
}

//MARK: - Sort

extension Sort {
  
  /// - Complexity: Θ(n^2)
  public static func bubbleSort<C>(
    _ coll: inout C,
    by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool) rethrows where
    C: RandomAccessCollection,
    C: MutableCollection {
      
      var index = coll.startIndex
      while index < coll.index(before: coll.endIndex) {
        
        var current = coll.index(before: coll.endIndex)
        while current > index {
          let previous = coll.index(before: current)
          if try areInIncreasingOrder(coll[current], coll[previous]) {
            coll.swapAt(current, previous)
          }
          coll.formIndex(before: &current)
        }
        coll.formIndex(after: &index)
      }
  }
  
  /// - Complexity: Θ(n^2)
  public static func bubbleSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable {
      bubbleSort(&coll) { $0 < $1 }
  }
  
}

//MARK: - Sort

extension Sort {
  
  /// - Complexity: O(n log(n))
  public static func heapSort<C>(
    _ coll: inout C,
    by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool) rethrows where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Index == Int {
      
      var heapCount = coll.count
      
      func heapify(index: Int) throws {
        let left = index << 1 + 1 // index * 2 + 1
        let right = index << 1 + 2 // index * 2 + 2
        
        var maxIndex = try left < heapCount && areInIncreasingOrder(coll[index], coll[left])
          ? left
          : index
        if try right < heapCount && areInIncreasingOrder(coll[maxIndex], coll[right]) {
          maxIndex = right
        }
        
        if maxIndex != index {
          coll.swapAt(index, maxIndex)
          try heapify(index: maxIndex)
        }
      }
      
      func buildHeap() throws {
        // heapCount / 2 internal nodes
        for index in stride(from: heapCount / 2 - 1, through: 0, by: -1) {
          try heapify(index: index)
        }
      }
      
      func sort() throws {
        for _ in stride(from: 0, to: coll.count - 1, by: 1) {
          heapCount -= 1
          coll.swapAt(0, heapCount)
          try heapify(index: 0)
        }
      }
      
      try buildHeap()
      try sort()
  }
  
  /// - Complexity: O(n log(n))
  public static func heapSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable,
    C.Index == Int {
      heapSort(&coll) { $0 < $1 }
  }
  
}

//MARK: - Sort

extension Sort {
  
  /// - Complexity: Θ(n log(n))
  public static func mergeSort<C>(
    _ coll: inout C,
    by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool) rethrows where
    C: RandomAccessCollection,
    C: MutableCollection {
      
      func merge(start: C.Index, middle: C.Index, end: C.Index) throws {
        var current1 = start, current2 = coll.index(after: middle)
        var tmp = [C.Element]()
        tmp.reserveCapacity(coll.distance(from: start, to: end) + 1)
        
        while current1 <= middle && current2 <= end {
          if try areInIncreasingOrder(coll[current1], coll[current2]) {
            tmp.append(coll[current1])
            coll.formIndex(after: &current1)
          } else {
            tmp.append(coll[current2])
            coll.formIndex(after: &current2)
          }
        }
        
        if current1 <= middle {
          tmp.append(contentsOf: coll[current1...middle])
        } else {
          tmp.append(contentsOf: coll[current2...end])
        }
        
        var index = start, i = tmp.startIndex
        while index <= end {
          coll[index] = tmp[i]
          tmp.formIndex(after: &i)
          coll.formIndex(after: &index)
        }
      }
      
      func sort(start: C.Index, end: C.Index) throws {
        guard start < end else {
          return
        }
        
        let middle = coll.index(start, offsetBy: coll.distance(from: start, to: end) / 2)
        try sort(start: start, end: middle)
        try sort(start: coll.index(after: middle), end: end)
        try merge(start: start, middle: middle, end: end)
      }
      
      try sort(start: coll.startIndex, end: coll.index(before: coll.endIndex))
  }
  
  /// - Complexity: Θ(n log(n))
  public static func mergeSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable {
      mergeSort(&coll) { $0 < $1 }
  }
  
}

//MARK: - Sort

private extension ComparisonResult {
  var orderedAscendingOrSame: Bool {
    self == .orderedAscending || self == .orderedSame
  }
}

extension Sort {
  
  /// - Complexity: O(n^2), average case: O(n log(n))
  public static func quickSort<C>(
    _ coll: inout C,
    by order: (C.Element, C.Element) throws -> ComparisonResult) rethrows where
    C: RandomAccessCollection,
    C: MutableCollection {
      
      func partition(start: C.Index, end: C.Index) throws -> C.Index {
        let pivot = coll[start]
        var inf = start, sup = end
        
        while inf < sup {
          
          while try inf < end && order(coll[inf], pivot).orderedAscendingOrSame {
            coll.formIndex(after: &inf)
          }
          
          while try order(coll[sup], pivot) == .orderedDescending {
            coll.formIndex(before: &sup)
          }
          
          if inf < sup {
            coll.swapAt(inf, sup)
          }
        }
        coll.swapAt(start, sup)
        return sup
      }
      
      func sort(start: C.Index, end: C.Index) throws {
        guard start < end else {
          return
        }
        let middle = try partition(start: start, end: end)
        try sort(start: start, end: coll.index(before: middle))
        try sort(start: coll.index(after: middle), end: end)
      }
      
      try sort(start: coll.startIndex, end: coll.index(before: coll.endIndex))
  }
  
  /// - Complexity: O(n^2), average case: O(n log(n))
  public static func quickSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable {
      quickSort(&coll) {
        if $0 == $1 {
          return .orderedSame
        } else {
          return $0 < $1 ? .orderedAscending : .orderedDescending
        }
      }
  }
  
}

//MARK: - Sort

extension Sort {
  
  /// - Complexity: O(n*k)  where k = max value - min value + 1
  public static func integerSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element == Int {
      guard let max = coll.max(), let min = coll.min(), max != min else {
        return
      }
      let rangeLength = max - min + 1
      var counter = [Int](repeating: 0, count: rangeLength)
      coll.forEach { counter[$0 - min] += 1 }
      
      var index = coll.startIndex
      for i in 0..<rangeLength {
        while counter[i] > 0 {
          coll[index] = i + min
          counter[i] -= 1
          coll.formIndex(after: &index)
        }
      }
  }
  
}
