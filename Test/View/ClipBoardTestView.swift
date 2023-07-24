//
//  ClipBoardTestView.swift
//  Test
//
//  Created by 清水脩輔 on 2023/07/25.
//

import SwiftUI

struct ClipBoardTestView: View {
    enum Field: Hashable {
        case copyTextField
        case pasteTextField
    }
    
    @ObservedObject private var viewModel = ClipBoardTestViewModel()
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("コピーする文字列を入力してください", text: $viewModel.copiedText)
                    .textFieldStyle(.roundedBorder)
                    .focused($focusedField, equals: .copyTextField)
                    .onTapGesture {
                        focusedField = .copyTextField
                    }
                Button {
                    viewModel.copyText()
                } label: {
                    Image(systemName: "square.on.square")
                }
            }
            Spacer()
            TextField("コピーした文字列をペーストしてください", text: $viewModel.pastedText)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .pasteTextField)
                .onTapGesture {
                    focusedField = .pasteTextField
                }
            Spacer()
        }
        .frame(maxWidth: .infinity  ,maxHeight: .infinity)
        .contentShape(RoundedRectangle(cornerRadius: 0))
        .onTapGesture {
            focusedField = .none
        }
    }
}
