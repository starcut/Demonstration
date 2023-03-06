//
//  RadioButtonsView.swift
//  Test
//
//  Created by 清水脩輔 on 2023/03/07.
//

import SwiftUI

struct RadioButtonsView: View {
    @ObservedObject var viewModel: RadioButtonsViewModel = RadioButtonsViewModel()
    
    let items = ["戦士", "武闘家", "僧侶", "魔法使い", "商人", "遊び人", "盗賊", "賢者"]
    
    var body: some View {
        VStack {
            Text("職業を選んでください")
//            verticalLayout()
            listLayout()
        }
    }
    
    private func verticalLayout() -> some View {
        return VStack (alignment: .leading) {
            ForEach(items, id: \.self) { item in
                radioButtonView(item: item)
                    .onTapGesture {
                        self.viewModel.updateSelectedItem(selectedItem: item)
                    }
            }
        }
    }
    
    // ラジオボタンと項目名のView
    private func radioButtonView(item: String) -> some View {
        return HStack {
            Button {
                self.viewModel.updateSelectedItem(selectedItem: item)
            } label: {
                Image(systemName: self.viewModel.getRadioButtonImage(item: item))
                    .font(.system(size: 20))
            }
            Text(item)
                .font(.system(size: 20))
        }
    }
    
    private func listLayout() -> some View {
        return List {
            ForEach(items, id: \.self) { item in
                radioButtonCell(item: item)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.updateSelectedItem(selectedItem: item)
                    }
            }
        }
    }
    
    // ラジオボタンと項目名のセル（セル全体がタップ対象領域）
    private func radioButtonCell(item: String) -> some View {
        return HStack {
            Image(systemName: self.viewModel.getRadioButtonImage(item: item))
                .font(.system(size: 20))
                .foregroundColor(self.viewModel.getRadioButtonColor(item: item))
            Text(item)
                .font(.system(size: 20))
            Spacer()
        }
    }
    
    
}
