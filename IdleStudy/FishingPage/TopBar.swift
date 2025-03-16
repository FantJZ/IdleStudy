//
//  TopBar.swift
//  IdleStudy
//
//  Created by JZ on 2025/3/16.
//

import SwiftUI

// MARK: - 顶部栏
struct topBarView: View {
    @Binding var startTiming: Bool
    @Binding var selectedTime: Double
    
    var body: some View {
        VStack {
            HStack {
                // Back/Close 按钮
                Button(action: {
                    // ...
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
                .padding(.leading)
                Spacer()
            }
            
            // 当开始计时后，显示正向 & 倒计时
            if startTiming {
                CountUpTimerView()
                CountdownTimerView(selectedTime: $selectedTime)
            }
        }
    }
}
