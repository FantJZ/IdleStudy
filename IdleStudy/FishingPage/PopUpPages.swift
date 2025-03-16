//
//  PopUpPages.swift
//  IdleStudy
//
//  Created by JZ on 2025/3/16.
//

import SwiftUI

// MARK: - 弹窗视图
struct TimeSelectorPopup: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedTime: Double
    @Binding var startTiming: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("选择时间：\(Int(selectedTime)) 小时")
                .font(.headline)
            
            Slider(value: $selectedTime, in: 0...12, step: 1)
                .padding(.horizontal)
            
            Button("确定") {
                // 用户确认后：设置 startTiming = true 并关闭弹窗
                startTiming = true
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}
