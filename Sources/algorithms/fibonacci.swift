import Foundation

/// - Complexity: O(log(n))
func fibonacci(_ n: Int) -> Int {
  precondition(n > 0, "n must be > zero")
  return Matrix(columns: 2, values: 1, 1, 1, 0).power(n - 1)[0, 0]
}
