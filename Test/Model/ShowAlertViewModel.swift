//
//  ShowAlertViewModel.swift
//  Test
//
//  Created by 清水脩輔 on 2023/03/14.
//

import Foundation

class ShowAlertViewModel: ObservableObject {
    @Published var isDefaultDialogPresented = false
    @Published var isDeleteDialogPresented = false
}
