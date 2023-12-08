import Algorithms
import Parsing
import IdentifiedCollections


struct Day08: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  enum Instruction: Equatable {
    case left, right
    
    static func parser() -> AnyParser<Substring, Instruction> {
      Parse {
        OneOf {
          "L".map{ Instruction.left}
          "R".map{ Instruction.right}
        }
      }.eraseToAnyParser()
    }
  }
  struct Node: Equatable, Identifiable {
    let id: String
    let leftID: String
    let rightID: String

    static func parser() -> AnyParser<Substring, Node> {
      let id = Parse(input: Substring.self, String.init) {
        Prefix(3)
      }

      return Parse(Node.init) {
        id
        " = ("
        id
        ", "
        id
        ")"
      }.eraseToAnyParser()
    }
  }
  struct Map: Equatable {
    let instructions: [Instruction]
    let nodes: [Node]
    
    static func parser() -> AnyParser<Substring, Map> {
      Parse(Map.init) {
        Many {
          Instruction.parser()
        }        
        "\n\n"
        Many {
          Node.parser()
        } separator: {
          "\n"
        } terminator: {
          "\n"
        }
      }.eraseToAnyParser()
    }
  }

  var map: Map {
    try! Day08.Map.parser().parse(data)
  }
  func steps(nodes: IdentifiedArrayOf<Node>, nodeID: String, end: (String) -> Bool ) -> Int {
    var result = 0
    var nodeID = nodeID
    for instruction in map.instructions.cycled() {
        let node = nodes[id: nodeID]!
        switch instruction {
        case .left : nodeID = node.leftID
        case .right: nodeID = node.rightID
        }
        result += 1
      if end(nodeID) { break }
    }
    return result
  }

  var steps: Int {
    return steps(nodes: IdentifiedArray(uniqueElements: map.nodes), nodeID: "AAA") {
      $0 == "ZZZ"
    }
  }
  
  func part1() -> Any {
    steps
  }

  var stepsSim: Int {
    let nodes = IdentifiedArray(uniqueElements: map.nodes)
    let nodeIDs = nodes.ids.filter {
      $0.last == "A"
    }
    var result:[Int] = []
    for nodeID in nodeIDs {
      let steps = steps(nodes: nodes, nodeID: nodeID) {
        $0.last == "Z"
      }
      result.append(steps)
    }
    return lcm(of: result)!
  }
  
  func part2() -> Any {
    stepsSim
  }

}

