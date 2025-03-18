//
//  Calculations.swift
//  IdleStudy
//
//  Created by JZ on 2025/3/17.
//

import Foundation
import SwiftUI
extension Double {
    /// 截断到指定小数位
    func truncated(to decimalPlaces: Int) -> Double {
        let multiplier = pow(10, Double(decimalPlaces))
        return floor(self * multiplier) / multiplier
    }
}

struct TestView: View {
    
    var body: some View{
        let FishWeightAndQuality = calculateWeight(fishName: "红鱼")
        Text("品质：\(FishWeightAndQuality.quality)")
        Text("重量：" + String(format: "%.2f", FishWeightAndQuality.weight) + " kg")
        Text("价格：\(calculatePrice(fishName: "红鱼", fishWeight: FishWeightAndQuality.weight, fishQuality: FishWeightAndQuality.quality))")
    }
}

//MARK: - 品质计算

//MARK: - 重量计算
func calculateWeight(fishName: String)  -> (quality:String, weight: Double) {
    var quality: String = ""
    var weight: Double = 0
    var minWeight: Double = 0
    var maxWeight: Double = 0
    
    // 先加载鱼数据
    guard let fishes = loadFishes() else {
        print("加载鱼数据失败")
        return ("", 0.0)
    }
    
    // 在数组中查找名称匹配的鱼
    if let fish = fishes.first(where: { $0.name == fishName }) {
        let maximumWeight = fish.maximumWeight
        let minimumWeight = fish.minimumWeight
        let difference = maximumWeight - minimumWeight
        
        let weightMin1 = minimumWeight + (difference / 5) * 1
        let weightMin2 = minimumWeight + (difference / 5) * 2
        let weightMin3 = minimumWeight + (difference / 5) * 3
        let weightMin4 = minimumWeight + (difference / 5) * 4
        
        //计算体长区间
        let result = randomEvent(5, 2, 3, 5, 2, 1)
        
        //计算随机到的区间
        if result == 1 {
            quality = "差劣"
            minWeight = minimumWeight
            maxWeight = weightMin1
        } else if result == 2 {
            quality = "不错"
            minWeight = weightMin1
            maxWeight = weightMin2
        } else if result == 3 {
            quality = "均等"
            minWeight = weightMin2
            maxWeight = weightMin3
        } else if result == 4 {
            quality = "良好"
            minWeight = weightMin3
            maxWeight = weightMin4
        } else if result == 5 {
            quality = "完美"
            minWeight = weightMin4
            maxWeight = maximumWeight
        }
        
        weight = Double.random(in: minWeight...maxWeight)
            .truncated(to: 2)
        if weight == maximumWeight {
            quality = "绝佳"
        }
    }
    return (quality: quality, weight: weight)
}

//MARK: - 价格计算
func calculatePrice (fishName: String, fishWeight: Double, fishQuality: String) -> Int {
    var price: Int = 0
    
    guard let fishes = loadFishes() else {
        print("加载鱼数据失败")
        return 0
    }
    if let fish = fishes.first(where: { $0.name == fishName }) {
        let fishBasedPrice = Double(fish.price)
        let maximumWeight: Double = fish.maximumWeight
        let fishWeight = fishWeight
        let fishQuality = fishQuality
        
        let weightFactor = (fishWeight / maximumWeight) * fishBasedPrice
        var qualityFactor: Double = 1
        
        print("FW \(fishWeight)")
        print("MW \(maximumWeight)")
        print("RATIO \(fishWeight / maximumWeight)")
        
        if fishQuality == "差劣" {
            qualityFactor = 1.0
        } else if fishQuality == "不错" {
            qualityFactor = 1.5
        } else if fishQuality == "均等" {
            qualityFactor = 2.0
        } else if fishQuality == "良好" {
            qualityFactor = 2.5
        } else if fishQuality == "完美" {
            qualityFactor = 3.0
        } else if fishQuality == "绝佳" {
            qualityFactor = 50.0
        }
        
        price = Int((fishBasedPrice + weightFactor) * qualityFactor)
    }
    
    return price
}

#Preview {
    TestView()
}
