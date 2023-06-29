//
//  ListMenuView.swift
//  Test
//
//  Created by 清水脩輔 on 2023/06/25.
//

import SwiftUI

struct ListMenuView: View {
    
    @ObservedObject private var viewModel: ListMenuViewModel = ListMenuViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                listView()
            }
            .navigationTitle("リストの備忘録動作確認")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    listOrderMenu()
                }
            }
        }
    }
    
    private func listView() -> some View {
        return List {
            ForEach(Array(viewModel.dataList.enumerated()), id: \.offset) { index, data in
                Button {
                    print("\(data)をタップしました。")
                } label: {
                    Text(data)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        viewModel.deleteData(index: index)
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button(role: .cancel) {
                        viewModel.bringTop(index: index)
                    } label: {
                        Image(systemName: "pin.fill")
                    }
                    .tint(.green)
                }
                .contextMenu(menuItems: {
                    cellMenu(index: index)
                })
            }
        }
    }
    
    private func cellMenu(index: Int) -> some View {
        return VStack {
            Button {
                print("編集する？")
            } label: {
                Text("編集")
            }
            Button {
                viewModel.deleteData(index: index)
            } label: {
                Text("削除")
                    .foregroundColor(.red)
            }
        }
    }
    
    private func listOrderMenu() -> some View {
        return Menu {
            ForEach(DataOrder.allCases, id:\.self) { dataOrder in
                Button {
                    viewModel.sortDataOrder(selectedOrder: dataOrder)
                } label: {
                    HStack {
                        if dataOrder == viewModel.selectedOrder {
                            Image(systemName: "checkmark")
                        }
                        Text(dataOrder.rawValue)
                    }
                }
            }
        } label: {
            Image(systemName: "arrow.up.and.down.text.horizontal")
        }
    }
}
