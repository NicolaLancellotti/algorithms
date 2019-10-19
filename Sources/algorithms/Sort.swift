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
  
}
