import SwiftUI

struct ContentView: View {
    @State private var selectedItem: Int? = nil
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(1...4, id: \.self) { index in
                    HStack {
                        Spacer()
                        Text("Item \(index)")
                            .font(.title2)
                            .fontWeight(.medium)
                            .frame(width: geometry.size.width * 0.8, height: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.1))
                            )
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .contentShape(Rectangle())
                    .scaleEffect(selectedItem == index && isAnimating ? 1.5 : 1.0)
                    .opacity(selectedItem == index && isAnimating ? 0 : 1.0)
                    .animation(.easeOut(duration: 0.3), value: isAnimating)
                    .onTapGesture {
                        selectedItem = index
                        isAnimating = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isAnimating = false
                            selectedItem = nil
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(PlainListStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
