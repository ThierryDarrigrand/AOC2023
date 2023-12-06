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

  struct Line: Equatable {
    let destinationRangeStart: Int
    let sourceRangeStart: Int
    let rangeLength: Int
  }
  static let line = Parse(input: Substring.self, Line.init) {
    Int.parser()
    " "
    Int.parser()
    " "
    Int.parser()
  }
  
  typealias Map = [Line]

  static func sourceToDestination(title: String) -> AnyParser<Substring, Map> {
    Parse {
      "\(title) map:\n"
      Many {
        line
      } separator: {
        "\n"
      } terminator: {
        "\n"
      }
    }.eraseToAnyParser()
  }

  struct Almanach {
    let seeds: [Int]
    let seedToSoil: Map
    let soilToFertilizer: Map
    let fertilizerToWater: Map
    let waterToLight: Map
    let lightToTemperature: Map
    let temperatureToHumidity: Map
    let humidityToLocation: Map
  }

  static let seeds = Parse {
    "seeds: "
    Many {
      Int.parser()
    } separator: {
      " "
    } terminator: {
      "\n"
    }
  }
  static let almanach = Parse(Almanach.init) {
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
  }
  var almanach: Almanach {
    try! Day05.almanach.parse(data)
  }
  func sourceToDestination(map: Map, _ source: Int) -> Int {
    for line in map {
      if source >= line.sourceRangeStart && source < line.sourceRangeStart + line.rangeLength {
        return source - line.sourceRangeStart + line.destinationRangeStart
      }
    }
    return source
  }
  var locations: [Int] {
    var result: [Int] = []
    for seed in almanach.seeds {
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
    locations.min()!
  }

  var seedsInRange: [Int] {
    var result: [Int] = []
    for chunk in almanach.seeds.chunks(ofCount: 2) {
      let start = chunk.first!
      let length = chunk.dropFirst().first!
      for n in 0..<length {
        result.append(start + n)
      }
    }
    return result
  }

  var locations2: [Int] {
    var result: [Int] = []
    for seed in seedsInRange {
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
  func part2() -> Any {
    locations2.min()!
  }

}
