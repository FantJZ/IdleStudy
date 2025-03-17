//
//  jsonDecode.swift
//  IdleStudy
//
//  Created by JZ on 2025/3/16.
//

import Foundation

struct Fish: Codable {
    let name: String
    let image: String
    let rarity: String
    let pond: String
    let maximumWeight: Double
    let minimumWeight: Double
    let price: Int

    enum CodingKeys: String, CodingKey {
        case name
        case image
        case rarity
        case pond
        case maximumWeight = "maximum weight"
        case minimumWeight = "minimum weight"
        case price
    }
}

func loadFishes() -> [Fish]? {
    // 获取 Bundle 中的 fish.json 文件路径
    guard let url = Bundle.main.url(forResource: "FishDataset", withExtension: "json") else {
        print("无法找到 fish.json 文件")
        return nil
    }
    
    do {
        // 读取文件数据
        let data = try Data(contentsOf: url)
        // 使用 JSONDecoder 将数据解码成 Fish 数组
        let fishArray = try JSONDecoder().decode([Fish].self, from: data)
        return fishArray
    } catch {
        print("解析 JSON 数据出错：\(error)")
        return nil
    }
}

