//
//  FishForegroundView.swift
//  IdleStudy
//
//  Created by JZ on 2025/3/16.
//

import SwiftUI

struct ForegroundView: View {
    @State var startTiming: Bool = false          // 是否开始计时
    @State var selectedTime: Double = 0           // 用户选择的时间（小时）
    
    var body: some View {
        VStack {
            // 顶部栏
            topBarView(startTiming: $startTiming, selectedTime: $selectedTime)
            Spacer()
            StartandEndButtons(startTiming: $startTiming, selectedTime: $selectedTime)
        }
    }
}
