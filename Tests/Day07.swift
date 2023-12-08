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
    XCTAssertEqual(challenge.bids, [
      Day071.Bid(hand: [.L3, .L2, .T, .L3, .K], bid: 765),
      Day071.Bid(hand: [.T, .L5, .L5, .J, .L5], bid: 684),
      Day071.Bid(hand: [.K, .K, .L6, .L7, .L7], bid: 28),
      Day071.Bid(hand: [.K, .T, .J, .J, .T], bid: 220),
      Day071.Bid(hand: [.Q, .Q, .Q, .J, .A], bid: 483),
    ])
  }
  func testBidsSorted() {
    let challenge = Day07(data: testData)
    XCTAssertEqual(challenge.bids.sorted(), [
      Day071.Bid(hand: [.L3, .L2, .T, .L3, .K], bid: 765),
      Day071.Bid(hand: [.K, .T, .J, .J, .T], bid: 220),
      Day071.Bid(hand: [.K, .K, .L6, .L7, .L7], bid: 28),
      Day071.Bid(hand: [.T, .L5, .L5, .J, .L5], bid: 684),
      Day071.Bid(hand: [.Q, .Q, .Q, .J, .A], bid: 483),
    ])
  }
  func testCount() {
    let challenge = Day07(data: testData)
    XCTAssertEqual(challenge.bids.map(\.count), [
      [.L3: 2, .T: 1, .L2: 1, .K: 1],
      [.T: 1,  .L5: 3,.J: 1],
      [.L7: 2, .L6: 1,.K: 2],
      [.J: 2,  .K: 1, .T: 2],
      [.J: 1,  .A: 1, .Q: 3],
    ])
  }
  func testPart1() throws {
    let challenge = Day07(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "6440")
  }
  func testBids2() {
    let challenge = Day07(data: testData)
    XCTAssertEqual(challenge.bids2, [
      Day071.BidJ(bid: Day071.Bid(hand: [.L3, .L2, .T, .L3, .K], bid: 765)),
      Day071.BidJ(bid: Day071.Bid(hand: [.T, .L5, .L5, .J, .L5], bid: 684)),
      Day071.BidJ(bid: Day071.Bid(hand: [.K, .K, .L6, .L7, .L7], bid: 28)),
      Day071.BidJ(bid: Day071.Bid(hand: [.K, .T, .J, .J, .T], bid: 220)),
      Day071.BidJ(bid: Day071.Bid(hand: [.Q, .Q, .Q, .J, .A], bid: 483)),
    ])
  }

  func testBids2Sorted() {
    let challenge = Day07(data: testData)
    XCTAssertEqual(challenge.bids2.sorted(), [
      Day071.BidJ(bid: Day071.Bid(hand: [.L3, .L2, .T, .L3, .K], bid: 765)),
      Day071.BidJ(bid: Day071.Bid(hand: [.K, .K, .L6, .L7, .L7], bid: 28)),
      Day071.BidJ(bid: Day071.Bid(hand: [.T, .L5, .L5, .J, .L5], bid: 684)),
      Day071.BidJ(bid: Day071.Bid(hand: [.Q, .Q, .Q, .J, .A], bid: 483)),
      Day071.BidJ(bid: Day071.Bid(hand: [.K, .T, .J, .J, .T], bid: 220)),
    ])
  }
  func testPart2() throws {
    let challenge = Day07(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "5905")
  }

}
