//
//  ContentView.swift
//  PlayButtonDemo
//
//  Created by IECS_MAC04 on 2020/10/25.
//

import SwiftUI

struct CounterView: View {
    @State private var counter = 1
    
    var body: some View {
        VStack {
            CounterButton(counter: $counter, color: .red)
            CounterButton(counter: $counter, color: .green)
            CounterButton(counter: $counter, color: .purple)
        }
    }
}

struct CounterButton: View {
    @Binding var counter: Int
    let color: Color
    
    var body: some View {
        Button(action: {
            counter += 1
        }) {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(color)
                .overlay(
                    Text("\(counter)")
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                )
        }
    }
}

struct ContentView: View {
    var body: some View {
        CounterView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
