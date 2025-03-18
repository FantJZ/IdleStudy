//
//  Functions.swift
//  IdleStudy
//
//  Created by JZ on 2025/3/17.
//

import SwiftUI

struct Functions: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//MARK: - 抽奖机
func randomEvent(_ count: Int, _ probabilities: Double...) -> Int? {
    // 1. 检查是否传入了正确数量的概率
    guard probabilities.count == count else {
        print("错误：期望 \(count) 个概率，实际给了 \(probabilities.count) 个")
        return nil
    }
    
    // 2. 计算总权重（即总概率）
    let total = probabilities.reduce(0, +)
    guard total > 0 else {
        print("错误：概率之和必须大于 0")
        return nil
    }
    
    // 3. 在 [0, total) 范围内生成随机数
    let randomValue = Double.random(in: 0..<total)
    
    // 4. 通过累加概率找到随机值所属的区间
    var cumulative = 0.0
    for i in 0..<count {
        cumulative += probabilities[i]
        if randomValue < cumulative {
            // 返回事件序号（这里用 1-based）
            return i + 1
        }
    }
    
    // 理论上不会执行到这里，除非出现浮点误差极端情况
    return nil
}

// 5 个事件，概率分别为 0.1, 0.2, 0.5, 0.1, 0.1
//if let result = randomEvent(5, 0.1, 0.2, 0.5, 0.1, 0.1) {
//    print("选中了第 \(result) 个事件")
//} else {
//    print("参数不合法，无法随机")
//}


//MARK: - 计时器
func getTimer(time: TimeInterval, handler: @escaping (Int) -> Void) -> Timer {
    var count = 0
    
    // 使用 scheduledTimer，每隔 `time` 秒重复触发
    let timer = Timer.scheduledTimer(withTimeInterval: time, repeats: true) { _ in
        count += 1
        handler(count)
    }
    
    // 将 Timer 添加到当前 RunLoop 中（默认就会添加在 common modes 下）
    RunLoop.current.add(timer, forMode: .common)
    
    return timer
}

//// 在某个需要的地方调用
//let myTimer = getTimer(time: 6) { newValue in
//    print("计时器触发次数：\(newValue)")
//}
//
//// 如果想停止计时器，可以在合适的时机执行：
//myTimer.invalidate()


#Preview {
    Functions()
}
