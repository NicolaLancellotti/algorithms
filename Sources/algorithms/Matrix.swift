import Foundation

public struct Matrix<T> {
  
  public let rows: Int, columns: Int
  private var grid: [T]
  
}

extension Matrix {
  
  public init(rows: Int, columns: Int, repeating: T) {
    self.rows = rows
    self.columns = columns
    grid = Array(repeating: repeating, count: rows * columns)
  }
  
  public init(columns: Int, values: T...) {
    self.rows = values.count / columns
    self.columns = columns
    grid = values
  }
  
}

extension Matrix {
  
  public subscript(row: Int, column: Int) -> T {
    get { grid[(row * columns) + column] }
    set { grid[(row * columns) + column] = newValue }
  }
  
  public var isSquare: Bool {
    rows == columns
  }
  
}

extension Matrix where T: Numeric {
  
  public static func makeIdentity(_ n: Int) -> Self {
    var matrix = Matrix(rows: n, columns: n, repeating: T.zero)
    for i in 0..<n {
      matrix[i, i] = T.zero + 1
    }
    return matrix
  }
  
  /// - Complexity: O(log(n))
  public func power(_ n: Int) -> Self {
    precondition(isSquare, "the matrix must be square")
    precondition(n >= 0, "n must be >= zero")
    
    switch n {
      case 0:
        return Matrix.makeIdentity(rows)
      case 1:
        return self
      default:
        var matrix = power(n / 2)
        matrix *= matrix
        if !n.isMultiple(of: 2) {
          matrix *= self
        }
        return matrix
    }
  }
  
}

extension Matrix where T: Numeric {
  
  static func *= (lhs: inout Self, rhs: Self) {
    lhs = lhs * rhs
  }
  
  static func * (lhs: Self, rhs: Self) -> Self {
    precondition(lhs.columns == rhs.rows)
    let rows = lhs.rows
    let columns = rhs.columns
    let commonDimension = lhs.columns
    var matrix = Matrix(rows: rows, columns: columns, repeating: T.zero)
    for row in 0..<rows {
      for col in 0..<columns {
        var value = T.zero;
        for i in 0..<commonDimension {
          value += lhs[row, i] * rhs[i, col]
        }
        matrix[row, col] = value
      }
    }
    return matrix
  }
}

extension Matrix: Equatable where T: Equatable {

}

extension Matrix: Hashable where T: Hashable {

}

extension Matrix: CustomDebugStringConvertible {
  
  public var debugDescription: String {
    var stream = String()
    for i in 0..<rows {
      for j in 0..<columns {
        print(self[i, j], separator: "", terminator: "\t", to: &stream)
      }
      print("", to: &stream)
    }
    return stream
  }
  
}
