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
  }
  struct Game {
    let id: Int
    let sets: [[(Int, Cube)]]
  }
  static let cube = Parse {
    OneOf {
      "red".map{Cube.red}
      "green".map{Cube.green}
      "blue".map{Cube.blue}
    }
  }
  static let set = Parse(input: Substring.self) {
    Many {
      Int.parser()
      " "
      cube
    } separator: {
      ", "
    }
  }
  static let game = Parse(Game.init) {
    "Game "
    Int.parser()
    ": "
    Many {
      set
    } separator: {
      "; "
    }
  }
  
  static let games = Many {
    game
  } separator: {
    "\n"
  } terminator: {
    "\n"
  }
  // Splits input data into its component parts and convert from string.
  var games: [Game] {
    try! Day02.games.parse(data)
  }
  
  func isPossible(_ set: [(Int, Cube)]) -> Bool {
    // [(Int, Cube)] -> [Cube: Int]
    let dict = Dictionary(uniqueKeysWithValues: set.map{count, cube in (cube, count)})
    return dict[.red, default: 0] <= 12 &&
    dict[.green, default: 0] <= 13 &&
    dict[.blue, default: 0] <= 14
  }
  
  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var possibleGames: [Int] = []
    for game in games {
      if game.sets.allSatisfy(isPossible) {
        possibleGames.append(game.id)
      }
    }
    return possibleGames.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var powers: [Int] = []
    for game in games {
      var minimumSet: [Cube: Int] = [:]
      for set in game.sets {
        let dict = Dictionary(uniqueKeysWithValues: set.map{count, cube in (cube, count)})
        minimumSet[.red] = max(minimumSet[.red, default: 0], dict[.red, default: 0])
        minimumSet[.green] = max(minimumSet[.green, default: 0], dict[.green, default: 0])
        minimumSet[.blue] = max(minimumSet[.blue, default: 0], dict[.blue, default: 0])
      }
      let power =
      minimumSet[.red, default: 0] *
      minimumSet[.green, default: 0] *
      minimumSet[.blue, default: 0]
      powers.append(power)
    }
    
    return powers.reduce(0, +)
  }
}

