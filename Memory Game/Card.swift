import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    let content: String
    var position: CGFloat = 0
}

