//
//  BMICalculator.swift
//  20241029Swift
//
//  Created by 訪客使用者 on 2024/10/29.
//

import SwiftUI

struct ContentView: View {
    // 使用 @State 來追蹤使用者輸入的身高、體重和計算結果
    @State private var height: String = "" // 儲存身高的輸入值
    @State private var weight: String = "" // 儲存體重的輸入值
    @State private var bmiResult: String = "BMI 結果會顯示在這裡" // 儲存 BMI 計算結果
    @State private var bmiStatus: String = "" // 儲存 BMI 狀態說明
    
    // BMI 計算函數
    private func calculateBMI() {
        // 檢查輸入值是否有效，將字串轉換為 Double 型別
        guard let h = Double(height),
              let w = Double(weight),
              h > 0 else { return }
        
        // 將身高從公分轉換為公尺
        let heightInMeters = h / 100
        // 使用 BMI 公式計算: BMI = 體重(kg) / 身高(m)²
        let bmi = w / (heightInMeters * heightInMeters)
        // 格式化 BMI 結果到小數點後一位
        bmiResult = String(format: "BMI: %.1f", bmi)
        
        // 根據 BMI 值判斷體重狀態
        if bmi < 18.5 {
            bmiStatus = "體重過輕"
        } else if bmi < 24 {
            bmiStatus = "體重正常"
        } else if bmi < 27 {
            bmiStatus = "體重過重"
        } else {
            bmiStatus = "肥胖"
        }
    }
    
    var body: some View {
        // 使用 VStack 垂直排列各個元件
        VStack(spacing: 20) {
            // 標題文字
            Text("BMI 計算機")
                .font(.title)
                .padding()
            
            // 身高輸入欄位
            TextField("請輸入身高(公分)", text: $height)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // 設定輸入框樣式
                .keyboardType(.decimalPad) // 使用數字鍵盤
                .padding(.horizontal)
            
            // 體重輸入欄位
            TextField("請輸入體重(公斤)", text: $weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding(.horizontal)
            
            // 計算按鈕
            Button(action: calculateBMI) {
                Text("計算 BMI")
                    .foregroundColor(.white) // 設定文字顏色
                    .padding()
                    .background(Color.blue) // 設定背景顏色
                    .cornerRadius(10) // 設定圓角
            }
            
            // 顯示 BMI 計算結果
            Text(bmiResult)
                .font(.title2)
                .padding()
            
            // 顯示 BMI 狀態，正常時顯示綠色，其他狀態顯示紅色
            Text(bmiStatus)
                .font(.title3)
                .foregroundColor(bmiStatus == "體重正常" ? .green : .red)
        }
        .padding()
    }
}

// 預覽用的結構體
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
