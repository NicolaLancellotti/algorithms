import Foundation

enum Sort {
  
  /// - Complexity: Θ(n^2)
  public static func selectionSort<C>(_ coll: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable {
      
      func indexMinElement(from index: C.Index) -> C.Index{
        var index = index
        var i = coll.index(after: index)
        while i < coll.endIndex {
          if coll[i] < coll[index] {
            index = i
          }
          coll.formIndex(after: &i)
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
        var i = coll.index(before: index)
        while i >= coll.startIndex && coll[i] > elem {
          coll[coll.index(after: i)] = coll[i]
          coll.formIndex(before: &i)
        }
        coll[coll.index(after: i)] = elem
        coll.formIndex(after: &index)
      }
  }
  
}
