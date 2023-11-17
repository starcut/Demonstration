//
//  CameraLaunchViewModel.swift
//  Test
//
//  Created by 清水脩輔 on 2023/08/03.
//

import Foundation

class CameraLaunchViewModel: ObservableObject {
    @Published var isLaunchedCamera = false    
    @Published var imageData = Data(capacity: 0)
}
