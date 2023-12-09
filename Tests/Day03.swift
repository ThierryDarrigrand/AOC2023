//
//  Day03.swift
//
//
//  Created by Thierry Darrigrand on 03/12/2023.
//

import XCTest

@testable import AdventOfCode

final class Day03Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """
  func testRow() {
    var data = testData[...]
    XCTAssertEqual(
      try! Day03.row.parse(&data),
      [.digit(4), .digit(6), .digit(7), .dot, .dot, .digit(1), .digit(1), .digit(4), .dot, .dot])
  }
  func testEngine() throws {
    let challenge = Day03(data: testData)

    XCTAssertEqual(
      challenge.engine[0],
      [.digit(4), .digit(6), .digit(7), .dot, .dot, .digit(1), .digit(1), .digit(4), .dot, .dot]
    )
    XCTAssertEqual(
      challenge.engine[1],
      [.dot, .dot, .dot, .symbol("*"), .dot, .dot, .dot, .dot, .dot, .dot]
    )

    XCTAssertEqual(challenge.engine.count, 10)
  }

  func testNumbers() {
    let challenge = Day03(data: testData)
    XCTAssertEqual(challenge.numbers, [467, 35, 633, 617, 592, 755, 664, 598])
  }

  func testPart1() throws {
    let challenge = Day03(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "4361")
  }
  func testNumbersAdjacent() {
    let challenge = Day03(data: testData)
    XCTAssertEqual(challenge.engine[1][3], .symbol("*"))
    XCTAssertEqual(challenge.numbersAdjacent(row: 1, col: 3), [467, 35])
    XCTAssertEqual(challenge.engine[4][3], .symbol("*"))
    XCTAssertEqual(challenge.numbersAdjacent(row: 4, col: 3), [617])
    XCTAssertEqual(challenge.engine[8][5], .symbol("*"))
    XCTAssertEqual(challenge.numbersAdjacent(row: 8, col: 5), [755, 598])
  }
  func testPart2() throws {
    let challenge = Day03(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "467835")
  }

}
