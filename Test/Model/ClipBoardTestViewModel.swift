//
//  ClipBoardTestViewModel.swift
//  Test
//
//  Created by 清水脩輔 on 2023/07/25.
//

import UIKit

class ClipBoardTestViewModel: ObservableObject {
    
    @Published var copiedText: String = ""
    @Published var pastedText: String = ""
    
    func copyText() {
        UIPasteboard.general.string = copiedText
    }
}
