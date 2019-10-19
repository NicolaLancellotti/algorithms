import Foundation

public enum Search {
  
  /// - Complexity: O(n)
  public static func sequential<S, T>(_ element: T,
                                      in sequence: S) -> (index: Int, element: T)?
    where S: Sequence, S.Element: Comparable, S.Element == T {
      for (index, elem) in sequence.enumerated() where elem == element  {
        return (index, elem)
      }
      return nil
  }
  
  /// - Complexity: O(log(n))
  public static func binary<C, T>(_ element: T,
                                  in collection: C) -> (index: C.Index, element: T)?
    where C: RandomAccessCollection, C.Element: Comparable, C.Element == T {
      var start = collection.startIndex
      var end = collection.index(before: collection.endIndex)
      
      while start <= end {
        let middle = collection.index(start,
                                      offsetBy: collection.distance(from: start, to: end) / 2)
        switch collection[middle] {
          case let middleElem where element < middleElem:
            end = collection.index(before: middle)
          case let middleElem where element > middleElem:
            start = collection.index(after: middle)
          case let middleElem:
            return (middle, middleElem)
        }
      }
      return nil
  }
  
}
