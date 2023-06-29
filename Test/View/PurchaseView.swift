//
//  PurchaseView.swift
//  Test
//
//  Created by 清水脩輔 on 2023/04/05.
//

import SwiftUI

struct PurchaseView: View {
    @ObservedObject var viewModel: PurchaseViewModel
    
    init() {
        self.viewModel = PurchaseViewModel()
    }
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                Task {
                    await Store.shared.requestProducts()
                    await Store.shared.updateCustomerProductStatus()
                    print(Store.shared.jems.count)
                    print(Store.shared.items.count)
                    print(Store.shared.subscriptions.count)
                    print(Store.shared.nonRenewables.count)
                }
            } label: {
                Text("更新")
            }
            Spacer()
            List {
                Section("消耗型 \(Store.shared.jems.count)件") {
                    ForEach(Store.shared.subscriptions) { subscription in
                        Text(subscription.id)
                    }
                }
                Section("非消耗型 \(Store.shared.items.count)件") {
                    ForEach(Store.shared.subscriptions) { subscription in
                        Text(subscription.id)
                    }
                }
                Section("サブスクリプト \(Store.shared.subscriptions.count)件") {
                    ForEach(Store.shared.subscriptions) { subscription in
                        Text(subscription.id)
                    }
                }
                Section("サブスクリプト（手動更新） \(Store.shared.nonRenewables.count)件") {
                    ForEach(Store.shared.subscriptions) { subscription in
                        Text(subscription.id)
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
        .onAppear {
            Task {
                await Store.shared.requestProducts()
                await Store.shared.updateCustomerProductStatus()
            }
        }
    }
}
