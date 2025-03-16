import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        ZStack {
            // 背景
            Color.gray
                .ignoresSafeArea(edges: .all)
            
            // 前景
            ForegroundView()
        }
    }
}

#Preview {
    ContentView()
}

struct ForegroundView: View {
    @State var startTiming: Bool = false          // 是否开始计时
    @State var selectedTime: Double = 0           // 用户选择的时间（小时）
    @State var isStartPressed: Bool = false       // 控制弹出弹窗
    
    var body: some View {
        VStack {
            // 顶部栏
            topBarView(startTiming: $startTiming, selectedTime: $selectedTime)
            
            Spacer()
            
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
}

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

