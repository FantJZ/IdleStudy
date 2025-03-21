//
//  ListFishesData.swift
//  IdleStudy
//
//  Created by JZ on 2025/3/16.
//

import SwiftUI

struct listFishesData: View{
    
    @Binding var showListFishes: Bool
    
    var body: some View{
        ZStack{
            //background
            Color.brown
                .ignoresSafeArea()
            
            VStack{
                HStack(){
                    Button(action: {
                        showListFishes = false
                    },
                           label: {
                        Image(systemName: "arrowshape.backward.fill")
                    })
                    .padding(.leading)
                    Spacer()
                }
                
                // 先从 loadFishes() 获取数据，如果为 nil 就用空数组 []
                let fishes = loadFishes() ?? []

                // 用 List 或 VStack 来布局
                List() {
                    // ForEach 直接遍历 fishes
                    ForEach(fishes, id: \.name) { fish in
                        VStack(alignment: .leading) {
                            Text("名称：\(fish.name)")
                            Image(systemName: fish.image)
                            Text("稀有度：\(fish.rarity)")
                            Text("池塘： \(fish.pond)")
                            Text("最大重量：\(fish.maximumWeight)")
                            Text("最小重量：\(fish.minimumWeight)")
                            Text("价格：\(fish.price)")
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listRowSpacing(20)
                .scrollContentBackground(.hidden)
                .background(Color.brown)            }
        }
    }
}

#Preview {
    listFishesData(showListFishes: .constant(true))
}
