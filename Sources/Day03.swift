//
//  Day03.swift
//
//
//  Created by Thierry Darrigrand on 03/12/2023.
//
import Parsing

struct Day03: AdventDay {

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  enum Cell: Equatable {
    case digit(Int)
    case symbol(String)
    case dot
    
    static func parser() -> AnyParser<Substring, Cell> {
      Parse {
        OneOf {
          Digits(1).map{ Cell.digit($0)}
          ".".map{ Cell.dot}
          Prefix(1, while:{$0 != "\n"}).map{Cell.symbol(String($0))}
        }
      }.eraseToAnyParser()
    }
  }
  static let row = Parse {
    Many {
      Cell.parser()
    } 
  }
  static let grid = Parse {
    Many {
      row
    } separator: {
      "\n"
    } 
  }

  var engine: [[Cell]] {
    try! Day03.grid.parse(data)
  }
  var rows: Int {
    engine.count
  }
  var cols: Int {
    engine[0].count
  }

  func isAdjacent(row: Int, col: Int) -> Bool {
    for r in row - 1...row + 1 where r >= 0 && r < rows {
      for c in col - 1...col + 1 where c >= 0 && c < cols {
        switch engine[r][c] {
        case .symbol: return true
        default: continue
        }
      }
    }
    return false
  }

  var numbers: [Int] {
    var result: [Int] = []
    for row in 0..<rows {
      var n = 0
      var isAdj = false
      for col in 0..<cols {
        switch engine[row][col] {
        case .dot, .symbol:
          if n != 0 {
            if isAdj { result.append(n) }
            n = 0
            isAdj = false
          }
        case .digit(let d):
          n = n * 10 + d
          isAdj = isAdj || isAdjacent(row: row, col: col)
        }
        if col == cols - 1 {
          if n != 0 && isAdj { result.append(n) }
        }
      }
    }
    return result
  }

  func part1() -> Any {
    numbers.reduce(0, +)
  }
  
  func numbersAdjacent(row: Int, col: Int) -> [Int] {
    var result: [Int] = []
    for r in row - 1...row + 1 where r >= 0 && r < rows {
      var n = 0
      var isAdj = false
      for c in 0..<cols {
        switch engine[r][c] {
        case .dot, .symbol:
          if n != 0 {
            if isAdj { result.append(n) }
            n = 0
            isAdj = false
          }
        case .digit(let d):
          //          if n == 0 && c > col+1 { break }
          n = n * 10 + d
          isAdj = isAdj || (col - 1...col + 1).contains(c)
        }
        if c == cols - 1 {
          if n != 0 && isAdj { result.append(n) }
        }
      }
    }
    return result
  }

  var gearRatios: [Int] {
    var result: [Int] = []
    for row in 0..<rows {
      for col in 0..<cols {
        if engine[row][col] == .symbol("*") {
          let numbers = numbersAdjacent(row: row, col: col)
          if numbers.count == 2 {
            result.append(numbers.reduce(1, *))
          }
        }
      }
    }
    return result
  }
  func part2() -> Any {
    gearRatios.reduce(0, +)
  }
}
