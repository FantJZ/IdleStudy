//
//  StartandEndButtons.swift
//  IdleStudy
//
//  Created by JZ on 2025/3/16.
//

import SwiftUI

struct StartandEndButtons: View {
    
    @Binding var startTiming: Bool
    @Binding var selectedTime: Double
    @State var isStartPressed: Bool = false       // 控制弹出弹窗
    
    var body: some View {
        // 根据 startTiming 显示不同按钮
        if !startTiming {
            // ---- Start 按钮 ----
            Button(action: {
                // 点下后弹出弹窗，让用户选择时间
                isStartPressed.toggle()
            }) {
                Text("Start")
                    .foregroundColor(.white)
                    .frame(width: 100, height: 75)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .font(.largeTitle)
            }
            // 用 sheet 弹出时间选择器
            .sheet(isPresented: $isStartPressed) {
                TimeSelectorPopup(
                    selectedTime: $selectedTime,
                    startTiming: $startTiming
                )
            }
        } else {
            // ---- End 按钮 ----
            Button(action: {
                // 停止计时逻辑
                startTiming = false
            }) {
                Text("End")
                    .foregroundColor(.white)
                    .frame(width: 100, height: 75)
                    .background(Color.red)
                    .cornerRadius(20)
                    .font(.largeTitle)
            }
        }
    }
}
