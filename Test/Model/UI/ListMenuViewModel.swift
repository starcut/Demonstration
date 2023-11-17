//
//  ListMenuViewModel.swift
//  Test
//
//  Created by 清水脩輔 on 2023/06/25.
//

import Foundation

enum DataOrder: String, CaseIterable, Identifiable {
    case titleAscendingOrder = "項目名の昇順"
    case titleDescendingOrder = "項目名の降順"
    
    var id: String { rawValue }
}

class ListMenuViewModel: ObservableObject {
    @Published private(set) var dataList: [String]
    @Published private(set) var selectedOrder: DataOrder = .titleAscendingOrder
    
    init() {
        dataList = []
        for index in 0 ..< 20 {
            dataList.append("データ\(index)")
        }
    }
    
    func sortDataOrder(selectedOrder: DataOrder) {
        self.selectedOrder = selectedOrder
        switch selectedOrder {
        case .titleAscendingOrder:
            dataList = dataList.sorted(by: {$0 < $1})
        case .titleDescendingOrder:
            dataList = dataList.sorted(by: {$1 < $0})
        }
    }
    
    func deleteData(index: Int) {
        dataList.remove(at: index)
    }
    
    func bringTop(index: Int) {
        let moveData = dataList.remove(at: index)
        dataList.insert(moveData, at: 0)
    }
}
