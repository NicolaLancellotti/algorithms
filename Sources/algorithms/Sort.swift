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

//MARK: - Insertion Sort

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

//MARK: - Bubble Sort

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

//MARK: - Heap Sort

extension Sort {
  
  /// - Complexity: O(n log(n))
  public static func heapSort<C>(
    _ coll: inout C,
    by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool) rethrows where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Index: FixedWidthInteger {
      
      var heapCount = C.Index(coll.count)
      
      func heapify(index: C.Index) throws {
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
          try heapify(index: C.Index(index))
        }
      }
      
      func sort() throws {
        for _ in stride(from: 0, to: coll.count - 1, by: 1) {
          heapCount -= 1
          coll.swapAt(C.Index.zero, heapCount)
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
    C.Index: FixedWidthInteger {
      heapSort(&coll) { $0 < $1 }
  }
  
}

//MARK: - Merge Sort

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

//MARK: - Quick Sort

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

//MARK: - Integer Sort

extension Sort {
  
  /// - Complexity: O(max(n, k))  where k = max value - min value + 1
  public static func integerSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: BinaryInteger {
      guard let max = coll.max(), let min = coll.min(), max != min else {
        return
      }
      
      var counter = [C.Element](repeating: 0, count: Int(max - min + 1))
      coll.forEach { counter[Int($0 - min)] += 1 }
      
      var index = coll.startIndex
      for (i, count) in counter.enumerated() {
        for _ in stride(from: count, to: 0, by: -1) {
          coll[index] = C.Element(i) + min
          coll.formIndex(after: &index)
        }
      }
  }
  
  /// - Complexity: O(max(n, k))  where k = max value - min value + 1
  public static func integerSort<C>(
    _ coll: inout C,
    toInteger: (C.Element) throws -> Int) rethrows where
    C: RandomAccessCollection,
    C: MutableCollection {
      
      guard let (min, max) = try Sort.minMax(&coll, toInteger: toInteger), max != min else {
        return
      }
      
      var counter = [[C.Element]](repeating: [C.Element](), count: max - min + 1)
      try coll.forEach { counter[try toInteger($0) - min].append($0) }
      
      var index = coll.startIndex
      for list in counter {
        for elem in list {
          coll[index] = elem
          coll.formIndex(after: &index)
        }
      }
  }
  
}

//MARK: - Counting Sort

extension Sort {
  
  /// - Complexity: O(max(n, k))  where k = max value - min value + 1
  public static func countingSort<C>(
    _ coll: inout C,
    toInteger: (C.Element) throws -> Int) rethrows where
    C: RandomAccessCollection,
    C: MutableCollection {
      
      guard let (min, max) = try Sort.minMax(&coll, toInteger: toInteger), max != min else {
        return
      }
      
      var counter = [Int](repeating: 0, count: max - min + 1)
      try coll.forEach { counter[try toInteger($0) - min] += 1 }
      
      for i in stride(from: 1, to: counter.count, by: 1) {
        counter[i] += counter[i - 1]
      }
      
      let tmpColl = try [C.Element](unsafeUninitializedCapacity: coll.count) { (buffer, count) in
        var index = coll.index(before: coll.endIndex)
        while index >= coll.startIndex  {
          let value = coll[index]
          let intValue = try toInteger(value) - min
          counter[intValue] -= 1
          buffer[counter[intValue]] = value
          count += 1
          coll.formIndex(before: &index)
        }
      }
      
      for (index, elem) in zip(coll.indices, tmpColl) {
        coll[index] = elem
      }
  }
  
  public static func countingSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: BinaryInteger {
      countingSort(&coll) { Int($0) }
  }
  
}

//MARK: - Utility

extension Sort {
  
  private static func minMax<C: Collection>(
    _ coll: inout C,
    toInteger: (C.Element) throws -> Int) rethrows -> (min: Int, max: Int)?{
    
    guard
      let maxValue = try coll.max (by: { try toInteger($0) < toInteger($1)}),
      let minValue = try coll.min (by: { try toInteger($0) < toInteger($1)})
      else {
        return nil
    }
    return (min: try toInteger(minValue), max: try toInteger(maxValue))
  }
  
}
