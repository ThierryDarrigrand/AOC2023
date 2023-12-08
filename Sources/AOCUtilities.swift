//
//  File.swift
//  
//
//  Created by Thierry Darrigrand on 08/12/2023.
//

import Numerics
extension Collection {
  public var headAndTail: (head: Element, tail: SubSequence)? {
    guard let head = first else { return nil }
    return (head, dropFirst())
  }
}
public func lcm<T: BinaryInteger>(of values: some Collection<T>) -> T? {
  guard let (head, tail) = values.headAndTail else { return nil }
  guard let lcmR = lcm(of: tail) else { return head }
  return head / gcd(head, lcmR) * lcmR
}
