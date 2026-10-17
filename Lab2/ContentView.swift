// Lab 2
// Group#: Individual
// Karsten Palmer
// October 17, 2026
import SwiftUI

struct ContentView: View {
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    @State private var cardSymbols = ["🐕", "🐈", "🦊", "🐼", "🐢", "🐬"].flatMap { [$0, $0] }.shuffled()
    @State private var faceUpCards = Array(repeating: false, count: 12)

    var body: some View {
        VStack(spacing: 12) {
            Text("Memory Match")
                .font(.largeTitle.weight(.semibold))

            Text("Tap a card to reveal the animal.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(cardSymbols.indices, id: \.self) { index in
                        Button {
                            withAnimation(.easeInOut(duration: 0.18)) {
                                faceUpCards[index].toggle()
                            }
                        } label: {
                            ZStack {
                                Text(cardSymbols[index])
                                    .font(.system(size: 40))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 14))

                                // The blue shape covers the emoji until the card is tapped.
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(.blue)
                                    .overlay {
                                        Image(systemName: "questionmark")
                                            .font(.title.bold())
                                            .foregroundStyle(.white)
                                    }
                                    .opacity(faceUpCards[index] ? 0 : 1)
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(faceUpCards[index] ? "Card \(index + 1), \(cardSymbols[index])" : "Card \(index + 1), face down")
                        .accessibilityHint("Double-tap to flip the card.")
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .frame(maxWidth: 440, maxHeight: .infinity)
        .padding(20)
    }
}

#Preview {
    ContentView()
}
