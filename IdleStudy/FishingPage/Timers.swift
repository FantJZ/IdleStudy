//
//  Timers.swift
//  IdleStudy
//
//  Created by JZ on 2025/3/16.
//

import SwiftUI
import Combine

struct Timers: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - 正向计时
struct CountUpTimerView: View {
    @State var secondElapse: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("经历时间：\(timeString)")
            .onReceive(timer) { _ in
                secondElapse += 1
            }
    }
    //新的comment
    
    var timeString: String {
        let hours = secondElapse / 3600
        let minutes = (secondElapse % 3600) / 60
        let seconds = secondElapse % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

// MARK: - 倒计时
struct CountdownTimerView: View {
    @Binding var selectedTime: Double
    
    @State private var remainingSeconds: Int = 0
    let timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timerCancellable: Cancellable? = nil
    
    var body: some View {
        Text("剩余时间：\(timeString)")
            .onAppear {
                remainingSeconds = Int(selectedTime * 3600)
                timerCancellable = timerPublisher.connect()
            }
            .onDisappear {
                timerCancellable?.cancel()
            }
            .onReceive(timerPublisher) { _ in
                if remainingSeconds > 0 {
                    remainingSeconds -= 1
                } else {
                    timerCancellable?.cancel()
                }
            }
    }
    
    private var timeString: String {
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
