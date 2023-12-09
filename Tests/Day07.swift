import XCTest

@testable import AdventOfCode

final class Day07Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483

    """
  func testBids() {
    let challenge = Day07(data: testData)
    XCTAssertEqual(
      challenge.bids,
      [
        Day071.Bid(hand: [.l3, .l2, .t, .l3, .k], bid: 765),
        Day071.Bid(hand: [.t, .l5, .l5, .j, .l5], bid: 684),
        Day071.Bid(hand: [.k, .k, .l6, .l7, .l7], bid: 28),
        Day071.Bid(hand: [.k, .t, .j, .j, .t], bid: 220),
        Day071.Bid(hand: [.q, .q, .q, .j, .a], bid: 483),
      ])
  }
  func testBidsSorted() {
    let challenge = Day07(data: testData)
    XCTAssertEqual(
      challenge.bids.sorted(),
      [
        Day071.Bid(hand: [.l3, .l2, .t, .l3, .k], bid: 765),
        Day071.Bid(hand: [.k, .t, .j, .j, .t], bid: 220),
        Day071.Bid(hand: [.k, .k, .l6, .l7, .l7], bid: 28),
        Day071.Bid(hand: [.t, .l5, .l5, .j, .l5], bid: 684),
        Day071.Bid(hand: [.q, .q, .q, .j, .a], bid: 483),
      ])
  }
  func testCount() {
    let challenge = Day07(data: testData)
    XCTAssertEqual(
      challenge.bids.map(\.count),
      [
        [.l3: 2, .t: 1, .l2: 1, .k: 1],
        [.t: 1, .l5: 3, .j: 1],
        [.l7: 2, .l6: 1, .k: 2],
        [.j: 2, .k: 1, .t: 2],
        [.j: 1, .a: 1, .q: 3],
      ])
  }
  func testPart1() throws {
    let challenge = Day07(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "6440")
  }
  func testBids2() {
    let challenge = Day07(data: testData)
    XCTAssertEqual(
      challenge.bids2,
      [
        Day071.BidJ(bid: Day071.Bid(hand: [.l3, .l2, .t, .l3, .k], bid: 765)),
        Day071.BidJ(bid: Day071.Bid(hand: [.t, .l5, .l5, .j, .l5], bid: 684)),
        Day071.BidJ(bid: Day071.Bid(hand: [.k, .k, .l6, .l7, .l7], bid: 28)),
        Day071.BidJ(bid: Day071.Bid(hand: [.k, .t, .j, .j, .t], bid: 220)),
        Day071.BidJ(bid: Day071.Bid(hand: [.q, .q, .q, .j, .a], bid: 483)),
      ])
  }

  func testBids2Sorted() {
    let challenge = Day07(data: testData)
    XCTAssertEqual(
      challenge.bids2.sorted(),
      [
        Day071.BidJ(bid: Day071.Bid(hand: [.l3, .l2, .t, .l3, .k], bid: 765)),
        Day071.BidJ(bid: Day071.Bid(hand: [.k, .k, .l6, .l7, .l7], bid: 28)),
        Day071.BidJ(bid: Day071.Bid(hand: [.t, .l5, .l5, .j, .l5], bid: 684)),
        Day071.BidJ(bid: Day071.Bid(hand: [.q, .q, .q, .j, .a], bid: 483)),
        Day071.BidJ(bid: Day071.Bid(hand: [.k, .t, .j, .j, .t], bid: 220)),
      ])
  }
  func testPart2() throws {
    let challenge = Day07(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "5905")
  }

}
