import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            ForEach(1...4, id: \.self) { index in
                Text("Item \(index)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
