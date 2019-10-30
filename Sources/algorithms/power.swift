import Foundation

enum Math {
  
  /// Compute the power: *base^exp* with the repeated squares method
  /// - Complexity: O(log(exp))
  static func power<T: FloatingPoint, E: BinaryInteger>(base: T, exp: E) -> T {
    switch exp {
      case 0:
        return 1
      case let x where x < 0 :
        return 1 / power(base: base, exp: exp * exp.signum())
      default:
        var value = power(base: base, exp: exp / 2)
        value *= value
        return exp.isMultiple(of: 2) ? value : value * base
    }
  }
  
  /// Compute the power: *base^exp* with the repeated squares method
  /// - Complexity: O(log(exp))
  static func power<T: BinaryInteger, E: UnsignedInteger>(base: T, exp: E) -> T {
    switch exp {
      case 0:
        return 1
      default:
        var value = power(base: base, exp: exp / 2)
        value *= value
        return exp.isMultiple(of: 2) ? value : value * base
    }
  }
}

