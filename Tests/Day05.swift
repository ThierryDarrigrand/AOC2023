//
//  Day05.swift
//
//
//  Created by Thierry Darrigrand on 05/12/2023.
//

import XCTest

@testable import AdventOfCode

final class Day05Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4

    """
  func testAlmanach() {
    let challenge = Day05(data: testData)
    XCTAssertEqual(challenge.almanach.seeds, [79, 14, 55, 13])
    XCTAssertEqual(
      challenge.almanach.seedToSoil,
      [
        Day05.Line(destinationRangeStart: 50, sourceRangeStart: 98, rangeLength: 2),
        Day05.Line(destinationRangeStart: 52, sourceRangeStart: 50, rangeLength: 48),
      ])
    XCTAssertEqual(
      challenge.almanach.soilToFertilizer,
      [
        Day05.Line(destinationRangeStart: 0, sourceRangeStart: 15, rangeLength: 37),
        Day05.Line(destinationRangeStart: 37, sourceRangeStart: 52, rangeLength: 2),
        Day05.Line(destinationRangeStart: 39, sourceRangeStart: 0, rangeLength: 15),
      ])
    XCTAssertEqual(
      challenge.almanach.fertilizerToWater,
      [
        Day05.Line(destinationRangeStart: 49, sourceRangeStart: 53, rangeLength: 8),
        Day05.Line(destinationRangeStart: 0, sourceRangeStart: 11, rangeLength: 42),
        Day05.Line(destinationRangeStart: 42, sourceRangeStart: 0, rangeLength: 7),
        Day05.Line(destinationRangeStart: 57, sourceRangeStart: 7, rangeLength: 4),
      ])
    XCTAssertEqual(
      challenge.almanach.waterToLight,
      [
        Day05.Line(destinationRangeStart: 88, sourceRangeStart: 18, rangeLength: 7),
        Day05.Line(destinationRangeStart: 18, sourceRangeStart: 25, rangeLength: 70),
      ])
    XCTAssertEqual(
      challenge.almanach.lightToTemperature,
      [
        Day05.Line(destinationRangeStart: 45, sourceRangeStart: 77, rangeLength: 23),
        Day05.Line(destinationRangeStart: 81, sourceRangeStart: 45, rangeLength: 19),
        Day05.Line(destinationRangeStart: 68, sourceRangeStart: 64, rangeLength: 13),
      ])
    XCTAssertEqual(
      challenge.almanach.temperatureToHumidity,
      [
        Day05.Line(destinationRangeStart: 0, sourceRangeStart: 69, rangeLength: 1),
        Day05.Line(destinationRangeStart: 1, sourceRangeStart: 0, rangeLength: 69),
      ])
    XCTAssertEqual(
      challenge.almanach.humidityToLocation,
      [
        Day05.Line(destinationRangeStart: 60, sourceRangeStart: 56, rangeLength: 37),
        Day05.Line(destinationRangeStart: 56, sourceRangeStart: 93, rangeLength: 4),
      ])

  }
  func testPart1() throws {
    let challenge = Day05(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "35")
  }
  func testSeedRanges() {
    let challenge = Day05(data: testData)
    XCTAssertEqual(challenge.seedRanges, [79..<93, 55..<68])
  }
  func testSourceToDestinationRange() {
    let challenge = Day05(data: testData)
    XCTAssertEqual(
      challenge.sourceToDestination(map: challenge.almanach.seedToSoil, sourceRange: 79..<93),
      [81..<95])
    XCTAssertEqual(
      challenge.sourceToDestination(map: challenge.almanach.soilToFertilizer, sourceRange: 81..<95),
      [81..<95])
    XCTAssertEqual(
      challenge.sourceToDestination(
        map: challenge.almanach.fertilizerToWater, sourceRange: 81..<95), [81..<95])
    XCTAssertEqual(
      challenge.sourceToDestination(map: challenge.almanach.waterToLight, sourceRange: 81..<95),
      [74..<88])
    XCTAssertEqual(
      challenge.sourceToDestination(
        map: challenge.almanach.lightToTemperature, sourceRange: 74..<88), [78..<81, 45..<56])
    XCTAssertEqual(
      challenge.sourceToDestination(
        map: challenge.almanach.temperatureToHumidity, sourceRange: 45..<56), [46..<57])
    XCTAssertEqual(
      challenge.sourceToDestination(
        map: challenge.almanach.humidityToLocation, sourceRange: 46..<57), [46..<56, 60..<61])
  }
  func testPart2() throws {
    let challenge = Day05(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "46")
  }

}
