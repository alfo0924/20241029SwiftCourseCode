import SwiftUI

struct ContentView: View {
    @State private var selectedItem: Int? = nil
    @State private var isAnimating = false
    
    var body: some View {
        List {
            ForEach(1...4, id: \.self) { index in
                HStack {
                    Spacer()
                    Text("Item \(index)")
                    Spacer()
                }
                .contentShape(Rectangle()) // 使整個區域可點擊
                .scaleEffect(selectedItem == index && isAnimating ? 1.5 : 1.0)
                .opacity(selectedItem == index && isAnimating ? 0 : 1.0)
                .animation(.easeOut(duration: 0.3), value: isAnimating)
                .onTapGesture {
                    selectedItem = index
                    isAnimating = true
                    
                    // 重置動畫狀態
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isAnimating = false
                        selectedItem = nil
                    }
                }
                .listRowBackground(Color.clear) // 讓背景透明
                .listRowInsets(EdgeInsets()) // 移除列表項目的內邊距
            }
        }
        .listStyle(PlainListStyle()) // 使用純列表樣式
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
