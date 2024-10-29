//
//  BMICalculator.swift
//  20241029Swift
//
//  Created by 訪客使用者 on 2024/10/29.
//

import SwiftUI

struct ContentView: View {
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bmiResult: String = "BMI 結果會顯示在這裡"
    @State private var bmiStatus: String = ""
    
    // BMI 計算函數
    private func calculateBMI() {
        guard let h = Double(height),
              let w = Double(weight),
              h > 0 else { return }
        
        // 將公分轉換為公尺
        let heightInMeters = h / 100
        // 計算 BMI
        let bmi = w / (heightInMeters * heightInMeters)
        bmiResult = String(format: "BMI: %.1f", bmi)
        
        // 判斷 BMI 狀態
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
        VStack(spacing: 20) {
            Text("BMI 計算機")
                .font(.title)
                .padding()
            
            TextField("請輸入身高(公分)", text: $height)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding(.horizontal)
            
            TextField("請輸入體重(公斤)", text: $weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding(.horizontal)
            
            Button(action: calculateBMI) {
                Text("計算 BMI")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Text(bmiResult)
                .font(.title2)
                .padding()
            
            Text(bmiStatus)
                .font(.title3)
                .foregroundColor(bmiStatus == "體重正常" ? .green : .red)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
