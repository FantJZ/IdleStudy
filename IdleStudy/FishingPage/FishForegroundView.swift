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
    @State var showListFishes: Bool = false
    
    var body: some View {
        ZStack{
            VStack {
                // 顶部栏
                topBarView(startTiming: $startTiming,
                           selectedTime: $selectedTime,
                           showListFishes: $showListFishes)
                
                Spacer()
                
                //底部按钮
                StartandEndButtons(startTiming: $startTiming,
                                   selectedTime: $selectedTime)
            }
            
            //显示鱼的目录
            if showListFishes == true {
                listFishesData(showListFishes: $showListFishes)
            }
        }
    }
}
