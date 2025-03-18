import SwiftUI
import Foundation

// MARK: - 1. 内存缓存：一次性加载鱼数据
final class FishDataCache {
    static let shared = FishDataCache()
    
    // 从你已有的 loadFishes() 中加载到内存
    let allFishes: [Fish]
    
    private init() {
        // 假设你已有的 loadFishes() 会返回 [Fish]?
        // 这里只在初始化时加载一次，后续都走缓存
        self.allFishes = loadFishes() ?? []
    }
}

// MARK: - 2. Double 扩展：截断到指定小数位
extension Double {
    func truncated(to decimalPlaces: Int) -> Double {
        let multiplier = pow(10, Double(decimalPlaces))
        return floor(self * multiplier) / multiplier
    }
}

// MARK: - 3. 计算逻辑函数们 —— 直接使用缓存 & 已有的随机函数
/// 从缓存里找到鱼，并根据随机结果返回 fishName
func getFishName(pondName: String) -> String {
    let fishes = FishDataCache.shared.allFishes
    // 根据 pondName 过滤同一池塘
    let pondFishes = fishes.filter { $0.pond == pondName }
    guard !pondFishes.isEmpty else { return "" }
    
    // 使用你已有的 randomEvent(...) 函数
    let result = randomEvent(5,10,6,3,1,0.1)
    switch result {
    case 1:
        if let fish = pondFishes.first(where: { $0.rarity == "普通" }) {
            return fish.name
        }
    case 2:
        if let fish = pondFishes.first(where: { $0.rarity == "稀有" }) {
            return fish.name
        }
    case 3:
        if let fish = pondFishes.first(where: { $0.rarity == "史诗" }) {
            return fish.name
        }
    case 4:
        if let fish = pondFishes.first(where: { $0.rarity == "传说" }) {
            return fish.name
        }
    case 5:
        if let fish = pondFishes.first(where: { $0.rarity == "至珍" }) {
            return fish.name
        }
    default:
        break
    }
    return ""
}

/// 根据 fishName 查找稀有度
func getRarity(fishName: String) -> String {
    let fishes = FishDataCache.shared.allFishes
    if let fish = fishes.first(where: { $0.name == fishName }) {
        return fish.rarity
    }
    return ""
}

/// 计算重量 & 品质
func calculateWeight(fishName: String) -> (quality: String, weight: Double) {
    let fishes = FishDataCache.shared.allFishes
    guard let fish = fishes.first(where: { $0.name == fishName }) else {
        return ("", 0.0)
    }
    
    let minW = fish.minimumWeight
    let maxW = fish.maximumWeight
    let diff = maxW - minW
    
    let weightMin1 = minW + (diff / 5) * 1
    let weightMin2 = minW + (diff / 5) * 2
    let weightMin3 = minW + (diff / 5) * 3
    let weightMin4 = minW + (diff / 5) * 4
    
    // 用你已有的 randomEvent(...) 函数
    let result = randomEvent(5,2,3,5,2,1)
    
    var quality = ""
    var rangeMin = minW
    var rangeMax = maxW
    
    switch result {
    case 1:
        quality = "差劣"
        rangeMin = minW
        rangeMax = weightMin1
    case 2:
        quality = "不错"
        rangeMin = weightMin1
        rangeMax = weightMin2
    case 3:
        quality = "均等"
        rangeMin = weightMin2
        rangeMax = weightMin3
    case 4:
        quality = "良好"
        rangeMin = weightMin3
        rangeMax = weightMin4
    case 5:
        quality = "完美"
        rangeMin = weightMin4
        rangeMax = maxW
    default:
        break
    }
    
    var weight = Double.random(in: rangeMin...rangeMax).truncated(to: 2)
    // 如果正好达到最大值，则设为“绝佳”
    if weight == maxW {
        quality = "绝佳"
    }
    return (quality, weight)
}

/// 计算价格
func calculatePrice(fishName: String, fishWeight: Double, fishQuality: String) -> Int {
    let fishes = FishDataCache.shared.allFishes
    guard let fish = fishes.first(where: { $0.name == fishName }) else {
        return 0
    }
    
    let basePrice = Double(fish.price)
    let maxW = fish.maximumWeight
    let weightFactor = (fishWeight / maxW) * basePrice
    
    var qualityFactor: Double = 1.0
    switch fishQuality {
    case "差劣":
        qualityFactor = 1.0
    case "不错":
        qualityFactor = 1.5
    case "均等":
        qualityFactor = 2.0
    case "良好":
        qualityFactor = 2.5
    case "完美":
        qualityFactor = 3.0
    case "绝佳":
        qualityFactor = 50.0
    default:
        qualityFactor = 1.0
    }
    
    return Int((basePrice + weightFactor) * qualityFactor)
}

// MARK: - 4. 示例视图，演示如何使用上述函数
struct FishCalculations: View {
    @State private var pondName: String = "小池塘"
    
    var body: some View {
        // 1) 一次性获取 fishName
        let fishName = getFishName(pondName: pondName)
        // 2) 计算质量、重量
        let (quality, weight) = calculateWeight(fishName: fishName)
        // 3) 计算价格
        let price = calculatePrice(
            fishName: fishName,
            fishWeight: weight,
            fishQuality: quality
        )
        // 4) 获取稀有度
        let rarity = getRarity(fishName: fishName)
        
        VStack(alignment: .leading) {
            Text("名称：\(fishName)")
            Text("品质：\(quality)")
            Text("重量：\(String(format: "%.2f", weight)) kg")
            Text("价格：\(price)")
            Text("稀有度：\(rarity)")
        }
        .padding()
    }
}

#Preview {
    FishCalculations()
}
