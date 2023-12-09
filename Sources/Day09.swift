import Parsing

struct Day09: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  static let value = Parse(input: Substring.self) {
    Many {
      Int.parser()
    } separator: {
      " "
    } terminator: {
      "\n"
    }
  }
  
  static let values = Parse {
    Many {
      value
    }
  }

  var report: [[Int]] {
    try! Day09.values.parse(data)
  }
  func diff(_ values: [Int]) -> [Int] {
    guard values.last! != 0 else { return values + [0] }
    var newValues = zip(values, values.dropFirst()).map{ $1-$0 }
    let prediction = prediction(newValues)
    return newValues+[prediction]
  }
  
  func prediction(_ values: [Int]) -> Int {
    diff(values).last! + values.last!
  }
    
  func part1() -> Any {
    report.map{values in
      prediction(values)
    }.reduce(0, +)
  }
  func diff2(_ values: [Int]) -> [Int] {
    guard values.last! != 0 else { return [0] + values }
    var newValues = zip(values, values.dropFirst()).map{ $1-$0 }
    let prediction = prediction2(newValues)
    return [prediction] + newValues
  }
  func prediction2(_ values: [Int]) -> Int {
    values.first! - diff2(values).first!
  }
  func part2() -> Any {
    report.map{values in
      prediction2(values)
    }.reduce(0, +)
  }

}
