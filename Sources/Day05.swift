//
//  Day05.swift
//
//
//  Created by Thierry Darrigrand on 05/12/2023.
//

import Algorithms
import Parsing

struct Day05: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  struct Line: Equatable, Comparable {
    let destinationRangeStart: Int
    let sourceRangeStart: Int
    let rangeLength: Int

    static func < (lhs: Self, rhs: Self) -> Bool {
      lhs.sourceRangeStart < rhs.sourceRangeStart
    }
    var sourceRange: Range<Int> {
      sourceRangeStart..<sourceRangeStart + rangeLength
    }
    var delta: Int {
      destinationRangeStart - sourceRangeStart
    }
    func destinationRange(sourceRange: Range<Int>) -> Range<Int> {
      sourceRange.lowerBound + delta..<sourceRange.upperBound + delta
    }

    static func parser() -> AnyParser<Substring, Line> {
      Parse(input: Substring.self, Line.init) {
        Int.parser()
        " "
        Int.parser()
        " "
        Int.parser()
      }.eraseToAnyParser()
    }
  }

  typealias Map = [Line]

  struct Almanach {
    let seeds: [Int]
    let seedToSoil: Map
    let soilToFertilizer: Map
    let fertilizerToWater: Map
    let waterToLight: Map
    let lightToTemperature: Map
    let temperatureToHumidity: Map
    let humidityToLocation: Map

    static func parser() -> AnyParser<Substring, Almanach> {
      let seeds = Parse {
        "seeds: "
        Many {
          Int.parser()
        } separator: {
          " "
        } terminator: {
          "\n"
        }
      }
      func sourceToDestination(title: String) -> AnyParser<Substring, Map> {
        Parse {
          "\(title) map:\n"
          Many {
            Line.parser()
          } separator: {
            "\n"
          } terminator: {
            "\n"
          }
        }.eraseToAnyParser()
      }
      return Parse(Almanach.init) {
        seeds
        "\n"
        sourceToDestination(title: "seed-to-soil")
        "\n"
        sourceToDestination(title: "soil-to-fertilizer")
        "\n"
        sourceToDestination(title: "fertilizer-to-water")
        "\n"
        sourceToDestination(title: "water-to-light")
        "\n"
        sourceToDestination(title: "light-to-temperature")
        "\n"
        sourceToDestination(title: "temperature-to-humidity")
        "\n"
        sourceToDestination(title: "humidity-to-location")
      }.eraseToAnyParser()
    }
  }

  var almanach: Almanach {
    try! Day05.Almanach.parser().parse(data)
  }
  func sourceToDestination(map: Map, _ source: Int) -> Int {
    for line in map {
      if source >= line.sourceRangeStart && source < line.sourceRangeStart + line.rangeLength {
        return source - line.sourceRangeStart + line.destinationRangeStart
      }
    }
    return source
  }
  func locations(seeds: [Int]) -> [Int] {
    var result: [Int] = []
    for seed in seeds {
      let soil = sourceToDestination(map: almanach.seedToSoil, seed)
      let fertilizer = sourceToDestination(map: almanach.soilToFertilizer, soil)
      let water = sourceToDestination(map: almanach.fertilizerToWater, fertilizer)
      let light = sourceToDestination(map: almanach.waterToLight, water)
      let temperature = sourceToDestination(map: almanach.lightToTemperature, light)
      let humidity = sourceToDestination(map: almanach.temperatureToHumidity, temperature)
      let location = sourceToDestination(map: almanach.humidityToLocation, humidity)
      result.append(location)
    }
    return result
  }

  func part1() -> Any {
    locations(seeds: almanach.seeds).min()!
  }

  var seedRanges: [Range<Int>] {
    var result: [Range<Int>] = []
    for chunk in almanach.seeds.chunks(ofCount: 2) {
      let start = chunk.first!
      let length = chunk.dropFirst().first!
      result.append(start..<start + length)
    }
    return result
  }
  func sourceToDestination(map: Map, sourceRange: Range<Int>) -> [Range<Int>] {
    let sortedMap = map.sorted()
    var destinationRanges: [Range<Int>] = []
    var start = sourceRange.lowerBound
    while sourceRange.contains(start) {
      let destinationRange: Range<Int>
      if let line = sortedMap.first(where: { $0.sourceRange.contains(start) }) {
        let range = start..<min(line.sourceRange.upperBound, sourceRange.upperBound)
        destinationRange = line.destinationRange(sourceRange: range)
        start = range.upperBound
      } else if let line = sortedMap.first(where: { start < $0.sourceRangeStart }) {
        destinationRange = start..<line.sourceRangeStart
        start = destinationRange.upperBound
      } else {
        destinationRange = start..<sourceRange.upperBound
        start = destinationRange.upperBound
      }
      destinationRanges.append(destinationRange)
    }
    return destinationRanges
  }

  func locationRanges(seedRanges: [Range<Int>]) -> [Range<Int>] {
    let soilRanges = seedRanges.reduce([]) { acc, seedRange in
      acc + sourceToDestination(map: almanach.seedToSoil, sourceRange: seedRange)
    }
    let fertilizerRanges = soilRanges.reduce([]) { acc, soilRange in
      acc + sourceToDestination(map: almanach.soilToFertilizer, sourceRange: soilRange)
    }
    let waterRanges = fertilizerRanges.reduce([]) { acc, fertilizerRange in
      acc + sourceToDestination(map: almanach.fertilizerToWater, sourceRange: fertilizerRange)
    }
    let lightRanges = waterRanges.reduce([]) { acc, waterRange in
      acc + sourceToDestination(map: almanach.waterToLight, sourceRange: waterRange)
    }
    let temperatureRanges = lightRanges.reduce([]) { acc, lightRange in
      acc + sourceToDestination(map: almanach.lightToTemperature, sourceRange: lightRange)
    }
    let humidityRanges = temperatureRanges.reduce([]) { acc, temperatureRange in
      acc + sourceToDestination(map: almanach.temperatureToHumidity, sourceRange: temperatureRange)
    }
    let locationRanges = humidityRanges.reduce([]) { acc, humidityRange in
      acc + sourceToDestination(map: almanach.humidityToLocation, sourceRange: humidityRange)
    }
    return locationRanges
  }
  func part2() -> Any {
    locationRanges(seedRanges: seedRanges)
      .map(\.lowerBound)
      .min()!
  }

}
