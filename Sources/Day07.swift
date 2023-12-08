import Parsing
enum Day071 {
  enum Label: Int, Equatable, Comparable {
    case L2=2, L3, L4, L5, L6, L7, L8, L9, T, J, Q, K, A
    static func < (lhs: Self, rhs: Self) -> Bool {
      lhs.rawValue < rhs.rawValue
      }
    }
  enum LabelJ: Int, Equatable, Comparable {
    case J=1, L2, L3, L4, L5, L6, L7, L8, L9, T, Q, K, A
    static func < (lhs: Self, rhs: Self) -> Bool {
      lhs.rawValue < rhs.rawValue
      }
    }

  static let label = Parse {
    OneOf {
      "2".map{Label.L2}
      "3".map{Label.L3}
      "4".map{Label.L4}
      "5".map{Label.L5}
      "6".map{Label.L6}
      "7".map{Label.L7}
      "8".map{Label.L8}
      "9".map{Label.L9}
      "T".map{Label.T}
      "J".map{Label.J}
      "Q".map{Label.Q}
      "K".map{Label.K}
      "A".map{Label.A}
    }
  }
  static let hand = Parse {
    Many(5) {
      label
    }
  }
  enum `Type`: Int, Equatable, Comparable {
    case none = 0
    case highCard
    case onePair
    case twoPair
    case threeOfAKind
    case fullHouse
    case fourOfAKind
    case fiveOfAKind
    static func < (lhs: Self, rhs: Self) -> Bool {
      lhs.rawValue < rhs.rawValue
    }
  }
  struct Bid: Equatable, Comparable {
    let hand: [Label]
    let bid: Int

    var count: [Label: Int] {
      hand.reduce(into: [:]) { partialResult, label in
        partialResult[label, default: 0] += 1
      }
    }
    var type: `Type` {
      switch Set(hand).count {
      case 1: .fiveOfAKind
      case 2:
        switch count.values.sorted() {
        case [1, 4]: .fourOfAKind
        case [2, 3]: .fullHouse
        default: fatalError()
        }
      case 3:
        switch count.values.sorted() {
        case [1, 1, 3]: .threeOfAKind
        case [1, 2, 2]: .twoPair
        default: fatalError()
        }
      case 4: .onePair
      case 5: .highCard
      default: .none
      }
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
      if lhs.type != rhs.type {
        lhs.type < rhs.type
      } else if lhs.hand[0] != rhs.hand[0] {
        lhs.hand[0] < rhs.hand[0]
      } else if lhs.hand[1] != rhs.hand[1] {
        lhs.hand[1] < rhs.hand[1]
      } else if lhs.hand[2] != rhs.hand[2] {
        lhs.hand[2] < rhs.hand[2]
      } else if lhs.hand[3] != rhs.hand[3] {
        lhs.hand[3] < rhs.hand[3]
      } else if lhs.hand[4] != rhs.hand[4] {
        lhs.hand[4] < rhs.hand[4]
      } else {
        false
      }
    }
  }

  struct BidJ: Equatable, Comparable {
    let bid: Bid
    var hand: [LabelJ] {
      bid.hand.map {
        switch $0 {
        case .L2: .L2
        case .L3: .L3
        case .L4: .L4
        case .L5: .L5
        case .L6: .L6
        case .L7: .L7
        case .L8: .L8
        case .L9: .L9
        case .T: .T
        case .J: .J
        case .Q: .Q
        case .K: .K
        case .A: .A
        }
      }
    }
    var type: `Type` {
      switch bid.count[.J] {
      case 5: .fiveOfAKind
      case 4: .fiveOfAKind
      case nil: bid.type
      case 1:
        switch bid.count.values.sorted() {
        case [1, 4]: .fiveOfAKind
        case [1, 1, 3]: .fourOfAKind
        case [1, 2, 2]: .fullHouse
        case [1, 1, 1, 2]: .threeOfAKind
        case [1, 1, 1, 1, 1]: .onePair
        default:
          fatalError()
        }
      case 2:
        switch bid.count.values.sorted() {
        case [1, 2, 2]: .fourOfAKind
        case [2, 3]: .fiveOfAKind
        case [1, 1, 1, 2]: .threeOfAKind
        default: fatalError()
        }
      case 3:
        switch bid.count.values.sorted() {
        case [1, 1, 3]: .fourOfAKind
        case [2, 3]: .fiveOfAKind
        default: fatalError()
        }
      default:
        fatalError()
      }
    }
    static func < (lhs: Self, rhs: Self) -> Bool {
      if lhs.type != rhs.type {
        lhs.type < rhs.type
      } else if lhs.hand[0] != rhs.hand[0] {
        lhs.hand[0] < rhs.hand[0]
      } else if lhs.hand[1] != rhs.hand[1] {
        lhs.hand[1] < rhs.hand[1]
      } else if lhs.hand[2] != rhs.hand[2] {
        lhs.hand[2] < rhs.hand[2]
      } else if lhs.hand[3] != rhs.hand[3] {
        lhs.hand[3] < rhs.hand[3]
      } else if lhs.hand[4] != rhs.hand[4] {
        lhs.hand[4] < rhs.hand[4]
      } else {
        false
      }
    }

  }
  static let bid = Parse(Bid.init) {
    hand
    " "
    Int.parser()
  }
  static let bids = Parse {
    Many {
      bid
    } separator: {
      "\n"
    } terminator: {
      "\n"
    }
  }
}
protocol BidProtocol {
  associatedtype Label: Hashable
  
  var hand: [Label] { get }
  var bid: Int { get }
  
  
}
enum `Type`: Int, Equatable, Comparable {
  case none = 0
  case highCard
  case onePair
  case twoPair
  case threeOfAKind
  case fullHouse
  case fourOfAKind
  case fiveOfAKind
  static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
extension BidProtocol {
  var count: [Label: Int] {
    hand.reduce(into: [:]) { partialResult, label in
      partialResult[label, default: 0] += 1
    }
  }
  var type: `Type` {
    switch Set(hand).count {
    case 1: .fiveOfAKind
    case 2:
      switch count.values.sorted() {
      case [1, 4]: .fourOfAKind
      case [2, 3]: .fullHouse
      default: fatalError()
      }
    case 3:
      switch count.values.sorted() {
      case [1, 1, 3]: .threeOfAKind
      case [1, 2, 2]: .twoPair
      default: fatalError()
      }
    case 4: .onePair
    case 5: .highCard
    default: .none
    }
  }
}
struct Day07: AdventDay {
  var data: String

  var bids: [Day071.Bid] {
    try! Day071.bids.parse(data)
  }
  var bids2: [Day071.BidJ] {
    bids.map{Day071.BidJ(bid: $0)}
  }

  func part1() -> Any {
    zip(1..., bids.sorted()).map{$0*$1.bid}.reduce(0, +)
  }
  func part2() -> Any {
    zip(1..., bids2.sorted()).map{$0*$1.bid.bid}.reduce(0, +)
  }

}
