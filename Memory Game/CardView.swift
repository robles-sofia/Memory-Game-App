import SwiftUI

struct CardView: View {
    
    @ObservedObject var viewModel: CardGameViewModel
    let card: Card
    @State private var dragAmount: CGSize = .zero
    
    var body: some View {
        ZStack {
            CardFront
            CardBack
        }
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .offset(dragAmount)
        .gesture(dragGesture)
        .onTapGesture(count: 2) {
            withAnimation {
                viewModel.selectCard(card)
            }
        }
        
        .opacity(card.isMatched ? 0.4 : 1)
        .animation(.easeInOut, value: card.isFaceUp)
    }
    
    private var CardFront: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .overlay(
                Text(card.content)
                    .font(Font.largeTitle)
            )
            .shadow(radius: 3)
            .opacity(card.isFaceUp ? 1 : 0)
    }
    
    private var CardBack: some View {
        
    }
}

