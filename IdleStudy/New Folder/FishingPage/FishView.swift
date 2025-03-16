//
//  FishView.swift
//  IdleStudy
//
//  Created by JZ on 2025/3/16.
//

import SwiftUI

struct FishView: View {
    var body: some View {
        ZStack {
            // 背景
            FishBackgroundView()
            
            // 前景
            ForegroundView()
        }
    }
}

#Preview {
    FishView()
}
