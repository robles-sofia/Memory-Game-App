import SwiftUI

struct MainGameView: View {
    
    @StateObject private var viewModel = CardGameViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.blue.opacity(0.2)
                    .ignoresSafeArea()
                
                if horizontalSizeClass == .compact {
                    VStack {
                        cardGrid(size: geometry.size)
                        ControlPanel(viewModel: viewModel)
                    }
                } else {
                    HStack {
                        cardGrid(size: geometry.size)
                        ControlPanel(viewModel: viewModel)
                            .frame(width: 250)
                    }
                }
            }
        }
    }
    
    private func cardGrid(size: CGSize) -> some View {
        let columns = [
            GridItem(.adaptive(minimum: 80))
        ]
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.cards) { card in
                    CardView(viewModel: viewModel, card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                }
            }
            
            .padding()
        }
    }
}

#Preview {
    MainGameView()
}
