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

#Preview {
    Functions()
}
