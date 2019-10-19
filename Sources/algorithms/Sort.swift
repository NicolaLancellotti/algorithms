import Foundation

enum Sort {
  
  /// - Complexity: Θ(n^2)
  public static func selectionSort<C>(_ collection: inout C) where
    C: RandomAccessCollection,
    C: MutableCollection,
    C.Element: Comparable {
      
      func indexMinElement(from index: C.Index) -> C.Index{
        var index = index
        var i = collection.index(after: index)
        while i < collection.endIndex {
          if collection[i] < collection[index] {
            index = i
          }
          collection.formIndex(after: &i)
        }
        return index
      }
      
      var index = collection.startIndex
      while index < collection.index(before: collection.endIndex) {
        collection.swapAt(index, indexMinElement(from: index))
        collection.formIndex(after: &index)
      }
  }
  
}
