//
//  Day01.swift
//
//
//  Created by Thierry Darrigrand on 03/12/2023.
//

import Algorithms

struct Day01: AdventDay {
  var data: String

  var calibrationValues: [Int] {
    data.split(separator: "\n").compactMap { line in
      guard let firstDigit = line.first(where: { $0.isNumber}),
            let lastDigit = line.reversed().first(where: {$0.isNumber})
      else { return nil }
      return Int(String(firstDigit))! * 10 + Int(String(lastDigit))!
    }
  }
  let digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  let digitsSpelledOut = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
 
  func convert(rawline: String, digitsSpelledOut: [String]) -> Substring {
    var newline: Substring = ""
    var rawline = rawline[...]
    
    while !rawline.isEmpty {
      for (offset, digit) in digitsSpelledOut.enumerated() {
        if rawline.hasPrefix(digit) {
          rawline = digits[offset] + rawline.dropFirst(digit.count)
          break
        }
      }
      newline.append(rawline.first!)
      rawline = rawline.dropFirst()
    }
    return newline
  }
  
  func convert(rawline: String, reversed: Bool = false) -> Substring {
    if reversed {
      convert(
        rawline: String(rawline.reversed()),
        digitsSpelledOut: digitsSpelledOut.map {String($0.reversed())}
      )
    } else {
      convert(
        rawline: rawline,
        digitsSpelledOut: digitsSpelledOut
      )
    }
  }

  var calibrationValuesSpelledOutWithLetters: [Int] {
    data.split(separator: "\n").compactMap {
      guard let firstDigit = convert(rawline: String($0)).first(where: { $0.isNumber}),
            let lastDigit = convert(rawline: String($0), reversed: true).first(where: {$0.isNumber})
      else { return nil }
      return Int(String(firstDigit))! * 10 + Int(String(lastDigit))!
    }

  }

  func part1() -> Any {
    // Sum the calibrationValues
    calibrationValues.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Sum the calibrationValuesSpelledOutWithLetters
    calibrationValuesSpelledOutWithLetters.reduce(0, +)
  }
}
