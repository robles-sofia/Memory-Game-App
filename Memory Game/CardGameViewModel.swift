import SwiftUI
import Combine


class CardGameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var score: Int = 0
    @Published var moves: Int = 0
    @Published var gameOver: Bool = false
    
    private var firstSelectedCardIndex: Int? = nil
    
    init() {
        startNewGame()
    }
    
    //Game setup
    func startNewGame() {
        let emojis = ["🐶", "🐻", "🐰", "🐱", "🐷", "🦊", "🐵", "🐯"]
        
        cards = []
        score = 0
        moves = 0
        gameOver = false
        firstSelectedCardIndex = nil
        
        for emoji in emojis {
            cards.append(Card(content: emoji))
            cards.append(Card(content: emoji))
        }
        shuffleCards()
    }
    
    func shuffleCards() {
        cards.shuffle()
    }
    
    //card selection logic
    func selectCard(_ selectedCard: Card) {
        guard let selectedIndex = cards.firstIndex(where: { $0.id == selectedCard.id}),
              !cards[selectedIndex].isFaceUp,
              !cards[selectedIndex].isMatched else {return}
        
        if let firstIndex = firstSelectedCardIndex {
            moves += 1
            
            if cards[firstIndex].content == cards[selectedIndex].content {
                cards[firstIndex].isMatched = true
                cards[selectedIndex].isMatched = true
                score += 2
                
                if cards.allSatisfy( { $0.isMatched } ) {
                    gameOver = true
                }
            } else {
                if score > 0 {
                    score -= 1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.cards[firstIndex].isFaceUp = false
                    self.cards[selectedIndex].isFaceUp = false
                }
            }
            
            firstSelectedCardIndex = nil
        } else {
            for index in cards.indices {
                if !cards[index].isMatched {
                    cards[index].isFaceUp = false
                }
            }
            
            firstSelectedCardIndex = selectedIndex
        }
        
        cards[selectedIndex].isFaceUp = true
    }
}
