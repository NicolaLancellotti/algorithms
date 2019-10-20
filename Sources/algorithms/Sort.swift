import Foundation

enum Sort {
  
  /// - Complexity: Θ(n^2)
  public static func selectionSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable {
      
      func indexMinElement(from index: C.Index) -> C.Index{
        var index = index
        var current = coll.index(after: index)
        while current < coll.endIndex {
          if coll[current] < coll[index] {
            index = current
          }
          coll.formIndex(after: &current)
        }
        return index
      }
      
      var index = coll.startIndex
      while index < coll.index(before: coll.endIndex) {
        coll.swapAt(index, indexMinElement(from: index))
        coll.formIndex(after: &index)
      }
  }
  
  /// - Complexity: O(n^2), best case: Θ(n)
  public static func insertionSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable {
      var index = coll.index(after: coll.startIndex)
      while index < coll.endIndex {
        let elem = coll[index]
        var current = coll.index(before: index)
        while current >= coll.startIndex && coll[current] > elem {
          coll[coll.index(after: current)] = coll[current]
          coll.formIndex(before: &current)
        }
        coll[coll.index(after: current)] = elem
        coll.formIndex(after: &index)
      }
  }
  
  /// - Complexity: Θ(n^2)
  public static func bubbleSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable {
      
      var index = coll.startIndex
      while index < coll.index(before: coll.endIndex) {
        
        var current = coll.index(before: coll.endIndex)
        while current > index {
          let previous = coll.index(before: current)
          if coll[previous] > coll[current] {
            coll.swapAt(current, previous)
          }
          coll.formIndex(before: &current)
        }
        coll.formIndex(after: &index)
      }
  }
  
  /// - Complexity: O(n^2)
  public static func heapSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable,
    C.Index == Int {
      
      var heapCount = coll.count
      
      func heapify(index: Int) {
        let left = index << 1 + 1 // index * 2 + 1
        let right = index << 1 + 2 // index * 2 + 2
        var maxIndex = left < heapCount && coll[left] > coll[index] ? left : index
        if right < heapCount && coll[right] > coll[maxIndex] {
          maxIndex = right
        }
        
        if maxIndex != index {
          coll.swapAt(index, maxIndex)
          heapify(index: maxIndex)
        }
      }
      
      func buildHeap() {
        // heapCount / 2 internal nodes
        for index in stride(from: heapCount / 2 - 1, through: 0, by: -1) {
          heapify(index: index)
        }
      }
      
      func sort() {
        for _ in stride(from: 0, to: coll.count - 1, by: 1) {
          heapCount -= 1
          coll.swapAt(0, heapCount)
          heapify(index: 0)
        }
      }
      
      buildHeap()
      sort()
  }
  
}
