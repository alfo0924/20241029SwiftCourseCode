//
//  BMICalculator.swift
//  20241029Swift
//
//  Created by 訪客使用者 on 2024/10/29.
//

import SwiftUI

// 定義 BMI 紀錄結構
struct BMIRecord: Identifiable {
    let id = UUID()
    let name: String
    let height: Double
    let weight: Double
    let bmi: Double
    let status: String
    let date: Date
}

struct ContentView: View {
    // 使用 @State 來追蹤使用者輸入的資料
    @State private var name: String = "" // 儲存姓名
    @State private var height: String = "" // 儲存身高的輸入值
    @State private var weight: String = "" // 儲存體重的輸入值
    @State private var bmiResult: String = "BMI 結果會顯示在這裡" // 儲存 BMI 計算結果
    @State private var bmiStatus: String = "" // 儲存 BMI 狀態說明
    @State private var bmiRecords: [BMIRecord] = [] // 儲存 BMI 紀錄
    @State private var isDarkMode: Bool = false // 追蹤深色模式狀態
    
    // 日期格式化
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
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
    
    // 儲存記錄函數
    private func saveRecord() {
        guard let h = Double(height),
              let w = Double(weight),
              !name.isEmpty else { return }
        
        let heightInMeters = h / 100
        let bmi = w / (heightInMeters * heightInMeters)
        
        let record = BMIRecord(
            name: name,
            height: h,
            weight: w,
            bmi: bmi,
            status: bmiStatus,
            date: Date()
        )
        
        bmiRecords.insert(record, at: 0) // 新記錄插入到最前面
    }
    
    var body: some View {
        // 使用 ScrollView 確保內容可以捲動
        ScrollView {
            // 使用 VStack 垂直排列各個元件
            VStack(spacing: 20) {
                // 標題列
                HStack {
                    Text("BMI 計算機")
                        .font(.title)
                    
                    Spacer()
                    
                    // 深色模式切換按鈕
                    Button(action: { isDarkMode.toggle() }) {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                            .font(.title2)
                            .foregroundColor(isDarkMode ? .yellow : .gray)
                    }
                }
                .padding()
                
                // 姓名輸入欄位
                TextField("請輸入姓名", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // 身高輸入欄位
                TextField("請輸入身高(公分)", text: $height)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
                
                // 體重輸入欄位
                TextField("請輸入體重(公斤)", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
                
                // 按鈕群組
                HStack(spacing: 20) {
                    // 計算按鈕
                    Button(action: calculateBMI) {
                        Text("計算 BMI")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    // 儲存按鈕
                    Button(action: saveRecord) {
                        Text("儲存紀錄")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                
                // 顯示 BMI 計算結果
                Text(bmiResult)
                    .font(.title2)
                    .padding()
                
                // 顯示 BMI 狀態
                Text(bmiStatus)
                    .font(.title3)
                    .foregroundColor(bmiStatus == "體重正常" ? .green : .red)
                
                // 歷史紀錄標題
                Text("歷史紀錄")
                    .font(.title2)
                    .padding(.top)
                
                // 顯示歷史紀錄
                ForEach(bmiRecords) { record in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("姓名: \(record.name)")
                        Text("身高: \(String(format: "%.1f", record.height)) 公分")
                        Text("體重: \(String(format: "%.1f", record.weight)) 公斤")
                        Text("BMI: \(String(format: "%.1f", record.bmi))")
                        Text("狀態: \(record.status)")
                        Text("日期: \(dateFormatter.string(from: record.date))")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(isDarkMode ? Color.gray.opacity(0.3) : Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .background(isDarkMode ? Color.black : Color.white)
        .foregroundColor(isDarkMode ? .white : .black)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

// 預覽用的結構體
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
