//
//  Day06.swift
//  
//
//  Created by Thierry Darrigrand on 06/12/2023.
//

import Parsing

struct Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  struct Race {
    let time: Int
    let distance: Int
  }
  static func line(title: String)-> AnyParser<Substring, [Int]> {
    Parse([Int].init) {
      "\(title):"
      Skip {
        Many {
          " "
        }
      }
      Many {
        Int.parser()
      } separator: {
        Many {
          " "
        }
      } terminator: {
        "\n"
      }
    }.eraseToAnyParser()
  }

  static let races = Parse {
    line(title: "Time")
    line(title: "Distance")
  }.map { times, distances in
    zip(times, distances).map(Race.init)
  }

  var races: [Race] {
    try! Day06.races.parse(data)
  }
  func numberOfWaysToWin(race: Race) -> Int {
    (0...race.time)
      .map { time in
        time * (race.time-time)
      }
      .filter{ $0 > race.distance }
      .count
  }

  func part1() -> Any {
    races.map(numberOfWaysToWin).reduce(1, *)
  }
  var longRace: Race {
    var time: String = ""
    var distance: String = ""
    for race in races {
      time.append(String(race.time))
      distance.append(String(race.distance))
    }
    return Race(time: Int(time)!, distance: Int(distance)!)
  }

  func part2() -> Any {
    numberOfWaysToWin(race: longRace)
  }
}
