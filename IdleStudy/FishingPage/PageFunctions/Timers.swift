import SwiftUI
import Combine

// MARK: - 正向计时
//struct CountUpTimerView: View {
//    @State var secondElapse: Int = 0
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    
//    var body: some View {
//        Text("经历时间：\(timeString)")
//            .onReceive(timer) { _ in
//                secondElapse += 1
//            }
//    }
//    
//    var timeString: String {
//        let hours = secondElapse / 3600
//        let minutes = (secondElapse % 3600) / 60
//        let seconds = secondElapse % 60
//        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
//    }
//}

// MARK: - 倒计时（selectedTime 以“分钟”为单位）
struct CountdownTimerView: View {
    /// 从父视图传进来的时间（单位：分钟）
    @Binding var selectedTime: Double
    /// 用于通知父视图：是否触发了“一分钟到达”事件
    @Binding var isOneMinute: Bool
    
    @State private var remainingSeconds: Int = 0
    @State private var timerCancellable: Cancellable? = nil
    
    let timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    
    var body: some View {
        
        Text("剩余时间：\(timeString)")
            .onAppear {
                // 将选定的分钟数转为秒
                remainingSeconds = Int(selectedTime * 60)
                // 启动计时器
                timerCancellable = timerPublisher.connect()
            }
            .onDisappear {
                timerCancellable?.cancel()
            }
            .onReceive(timerPublisher) { _ in
                if remainingSeconds > 0 {
                    remainingSeconds -= 1
                    
                    print(remainingSeconds)
                    
                    // 每当剩余秒数恰好能被 60 整除，就说明又过去了一整分钟
                    if remainingSeconds % 60 == 0 {
                        // 通知父视图：刚过了一分钟
                        isOneMinute = true
                    }
                } else {
                    // 倒计时完成，停止计时器
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

