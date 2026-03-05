import SwiftUI

struct MainGameView: View {
    
    @StateObject private var viewModel = CardGameViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //background
                Color.blue.opacity(0.2)
                    .ignoresSafeArea()
                
                //main content
                if horizontalSizeClass == .regular {
                    //horizontal stack
                    HStack(alignment: .top, spacing: 20) {
                        cardGrid(size: geometry.size)
                        ControlPanel(viewModel: viewModel)
                            .frame(width: geometry.size.width * 0.3)
                    }
                    .padding()
                } else {
                    //vertical
                    VStack(spacing: 20) {
                        cardGrid(size: geometry.size)
                            .offset(y: 90)
                        ControlPanel(viewModel: viewModel)
                            .frame(height: 250)
                    }
                    .padding()
                }
            }
        }
    }
    
    //card grid
    private func cardGrid(size: CGSize) -> some View {
        //columns based on orientation
        let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
        
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.cards) { card in
                    CardView(viewModel: viewModel, card: card)
                        .aspectRatio(0.9, contentMode: .fit)
                }
            }
            
            .padding()
        }
    }
}

#Preview {
    MainGameView()
}
