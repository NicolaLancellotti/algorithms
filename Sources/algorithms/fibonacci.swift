import Foundation

/// - Complexity: O(n)
public func fibonacci1(_ n: Int) -> Int {
  precondition(n > 0, "n must be > zero")
  var old = 1, current = 1
  for _ in stride(from: 3, through: n, by: 1) {
    (old, current) = (current, old + current)
  }
  return current
}

/// - Complexity: O(log(n))
public func fibonacci2(_ n: Int) -> Int {
  precondition(n > 0, "n must be > zero")
  return Matrix(columns: 2, values: 1, 1, 1, 0).power(n - 1)[0, 0]
}
