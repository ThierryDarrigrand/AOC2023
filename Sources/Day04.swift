//
//  Day04.swift
//
//
//  Created by Thierry Darrigrand on 05/12/2023.
//

import Parsing

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  struct ScratchCard {
    let id: Int
    let winningNumbers: [Int]
    let numbers: [Int]

    var value: Int {
      let n = Set(numbers).intersection(Set(winningNumbers)).count
      guard n != 0 else { return 0 }
      var result: Int = 1
      for _ in 0..<n - 1 {
        result *= 2
      }
      return result
    }

    var matchingNumbers: Int {
      Set(numbers).intersection(Set(winningNumbers)).count
    }
    static func parser() -> AnyParser<Substring, ScratchCard> {
       Parse(ScratchCard.init) {
        "Card"
        Skip {
          Many {
            " "
          }
        }
        Int.parser()
        ": "
        Many {
          Skip {
            Optionally {
              " "
            }
          }
          Int.parser()
        } separator: {
          " "
        } terminator: {
          " | "
        }
        Many {
          Skip {
            Optionally {
              " "
            }
          }
          Int.parser()
        } separator: {
          " "
        } terminator: {
          "\n"
        }
       }.eraseToAnyParser()
    }
  }

  static let cards = Parse {
    Many {
      ScratchCard.parser()
    }
  }
  // Converts input data into its scratchcards from string.
  var scratchCards: [ScratchCard] {
    try! Day04.cards.parse(data)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    // Calculate the sum of the first set of input data
    scratchCards.map(\.value).reduce(0, +)
  }
  var countProcessedCards: [Int] {
    var result = Array(repeating: 1, count: scratchCards.count)
    for card in scratchCards {
      let id = card.id
      for n in 0..<card.matchingNumbers where id + n < scratchCards.count {
        result[id + n] += result[id - 1]
      }
    }
    return result
  }

  func part2() -> Any {
    countProcessedCards.reduce(0, +)
  }

}
