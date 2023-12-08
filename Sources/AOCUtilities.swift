//
//  File.swift
//  
//
//  Created by Thierry Darrigrand on 08/12/2023.
//

import Numerics

//public func lcm<I: FixedWidthInteger>(_ values: I ...) -> I {
//    return lcm(of: values)
//}

public func lcm<C: Collection>(of values: C) -> C.Element where C.Element: FixedWidthInteger {
    let v = values.first!
    let r = values.dropFirst()
    if r.isEmpty { return v }
    
    let lcmR = lcm(of: r)
    return v / gcd(v, lcmR) * lcmR
}
