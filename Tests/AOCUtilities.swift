//
//  AOCUtilities.swift
//  
//
//  Created by Thierry Darrigrand on 08/12/2023.
//

import XCTest
@testable import AdventOfCode

final class AOCUtilitiesTests: XCTestCase {
  func testHeadTail() {
    XCTAssertNil([].headAndTail)
    XCTAssertEqual([0].headAndTail?.0, 0)
    XCTAssertEqual([0].headAndTail?.1, [])
    XCTAssertEqual([0, 1].headAndTail?.0, 0)
    XCTAssertEqual([0, 1].headAndTail?.1, [1])
  }
  
  func testLcm() {
    XCTAssertEqual(lcm(of:[2, 6]), 6)
    XCTAssertEqual(lcm(of:[2, 3]), 6)
    XCTAssertEqual(lcm(of:[2]), 2)
    XCTAssertNil(lcm(of:Array<Int>()))
  }

}
