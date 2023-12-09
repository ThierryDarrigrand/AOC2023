//
//  File.swift
//
//
//  Created by Thierry Darrigrand on 08/12/2023.
//

import Numerics

//extension Collection {
//  public var headAndTail: (head: Element, tail: SubSequence)? {
//    guard let head = first else { return nil }
//    return (head, dropFirst())
//  }
//}
///If the sequence of values is empty, the result is 1
public func lcm<T: BinaryInteger>(of values: some Sequence<T>) -> T {
  values.reduce(1) { acc, n in
    n / gcd(n, acc) * acc
  }
}
