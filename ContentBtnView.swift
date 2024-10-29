//
//  ContentView.swift
//  PlayButtonDemo
//
//  Created by IECS_MAC04 on 2020/10/25.
//

import SwiftUI

// 計數器視圖,包含三個不同顏色的按鈕
struct CounterView: View {
    // 使用 @State 來追蹤計數器的狀態
    @State private var counter = 1
    
    var body: some View {
        // 垂直堆疊三個按鈕
        VStack {
            // 傳入共享的計數器狀態和不同的顏色
            CounterButton(counter: $counter, color: .red)    // 紅色按鈕
            CounterButton(counter: $counter, color: .green)  // 綠色按鈕
            CounterButton(counter: $counter, color: .purple) // 紫色按鈕
        }
    }
}

// 可重複使用的計數器按鈕元件
struct CounterButton: View {
    // 使用 @Binding 來綁定父視圖的計數器狀態
    @Binding var counter: Int
    // 按鈕顏色屬性
    let color: Color
    
    var body: some View {
        Button(action: {
            // 點擊時計數器加1
            counter += 1
        }) {
            // 繪製圓形按鈕
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(color)
                // 在圓形上方疊加計數文字
                .overlay(
                    Text("\(counter)")
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                )
        }
    }
}

// 主要內容視圖
struct ContentView: View {
    var body: some View {
        CounterView()
    }
}

// 預覽提供者
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
