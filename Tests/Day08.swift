import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day08Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    
    """
  let testData2 = """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    
    """
  func testMap() {
    let challenge = Day08(data: testData2)
    XCTAssertEqual(challenge.map, Day08.Map(
      instructions: [
        .left,
        .left,
        .right,
      ],
      nodes: [
        Day08.Node(id: "AAA", leftID: "BBB", rightID: "BBB"),
        Day08.Node(id: "BBB", leftID: "AAA", rightID: "ZZZ"),
        Day08.Node(id: "ZZZ", leftID: "ZZZ", rightID: "ZZZ"),
      ]))
  }
  func testPart1() throws {
    XCTAssertEqual(String(describing: Day08(data: testData).part1()), "2")
    XCTAssertEqual(String(describing: Day08(data: testData2).part1()), "6")
  }
  let testData3 = """
  LR

  11A = (11B, XXX)
  11B = (XXX, 11Z)
  11Z = (11B, XXX)
  22A = (22B, XXX)
  22B = (22C, 22C)
  22C = (22Z, 22Z)
  22Z = (22B, 22B)
  XXX = (XXX, XXX)
  
  """

  func testPart2() throws {
    let challenge = Day08(data: testData3)
    XCTAssertEqual(String(describing: challenge.part2()), "6")
  }
}
