//
//  Day02.swift
//
//
//  Created by Thierry on 03/12/2023.
//

import Parsing

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  enum Cube: Equatable {
    case red
    case green
    case blue

    static func parser() -> AnyParser<Substring, Cube> {
      Parse {
        OneOf {
          "red".map { Cube.red }
          "green".map { Cube.green }
          "blue".map { Cube.blue }
        }
      }.eraseToAnyParser()
    }
  }
  struct Game {
    let id: Int
    let sets: [[(Int, Cube)]]

    static func parser() -> AnyParser<Substring, Game> {
      let set = Parse(input: Substring.self) {
        Many {
          Int.parser()
          " "
          Cube.parser()
        } separator: {
          ", "
        }
      }
      return Parse(Game.init) {
        "Game "
        Int.parser()
        ": "
        Many {
          set
        } separator: {
          "; "
        }
      }.eraseToAnyParser()
    }
  }

  static let games = Many {
    Game.parser()
  } separator: {
    "\n"
  } terminator: {
    "\n"
  }
  // Splits input data into its component parts and convert from string.
  var games: [Game] {
    try! Day02.games.parse(data)
  }

  func isPossible(set: [(Int, Cube)]) -> Bool {
    // [(Int, Cube)] -> [Cube: Int]
    let dict = Dictionary(uniqueKeysWithValues: set.map { count, cube in (cube, count) })
    return dict[.red, default: 0] <= 12 && dict[.green, default: 0] <= 13
      && dict[.blue, default: 0] <= 14
  }

  var possibleGames: [Int] {
    var possibleGames: [Int] = []
    for game in games {
      if game.sets.allSatisfy(isPossible) {
        possibleGames.append(game.id)
      }
    }
    return possibleGames
  }

  func part1() -> Any {
    possibleGames.reduce(0, +)
  }

  var powers: [Int] {
    var powers: [Int] = []
    for game in games {
      var minimumSet: [Cube: Int] = [:]
      for set in game.sets {
        let dict = Dictionary(uniqueKeysWithValues: set.map { count, cube in (cube, count) })
        minimumSet[.red] = max(minimumSet[.red, default: 0], dict[.red, default: 0])
        minimumSet[.green] = max(minimumSet[.green, default: 0], dict[.green, default: 0])
        minimumSet[.blue] = max(minimumSet[.blue, default: 0], dict[.blue, default: 0])
      }
      let power =
        minimumSet[.red, default: 0] * minimumSet[.green, default: 0]
        * minimumSet[.blue, default: 0]
      powers.append(power)
    }

    return powers
  }

  func part2() -> Any {
    powers.reduce(0, +)
  }
}
