//
//  SourceOfTruth.swift
//  20241029Swift
//
//  Created by 訪客使用者 on 2024/10/29.
//

import SwiftUI

// 主要視圖結構
struct SourceOfTruth: View {
    // 使用 @State 來追蹤標題文字的狀態
    @State private var title: String = "Hi"
    
    var body: some View {
        // 垂直堆疊視圖元件
        VStack(spacing: 20) {
            // 顯示標題文字
            Text(title)
                .font(.title)
            
            // 文字輸入框,綁定到 title 狀態
            TextField("請輸入文字", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            // 按鈕用於改變標題文字
            Button(action: {
                self.title = "Changed"
            }) {
                Text("Change")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

// 預覽提供者
struct SourceOfTruth_Previews: PreviewProvider {
    static var previews: some View {
        SourceOfTruth()
    }
}
