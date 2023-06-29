//
//  PurchaseViewModel.swift
//  Test
//
//  Created by 清水脩輔 on 2023/04/11.
//

import Foundation

class PurchaseViewModel: ObservableObject {
    init() {
        
    }
    
    static func loadStoreProject() async {
        await Store.shared.requestProducts()
    }
}

