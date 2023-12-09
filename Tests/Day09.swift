import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day09Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    
    """

  func testReport() {
    let challenge = Day09(data: testData)
    XCTAssertEqual(challenge.report, [
      [0, 3, 6, 9, 12, 15],
      [1, 3, 6, 10, 15, 21],
      [10, 13, 16, 21, 30, 45],
    ])
  }
  func testPrediction() {
    let challenge = Day09(data: testData)
    XCTAssertEqual(challenge.prediction(challenge.report[0]), 18)

  }
  func testPart1() throws {
    let challenge = Day09(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "114")
  }
  func testPrediction2() {
    let challenge = Day09(data: testData)
    XCTAssertEqual(challenge.prediction2(challenge.report[2]), 5)
  }
  func testPart2() throws {
    let challenge = Day09(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "2")
  }
}
