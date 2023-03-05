//
//  TestApp.swift
//  Test
//
//  Created by 清水脩輔 on 2023/02/05.
//

import SwiftUI

@main
struct TestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            PickerView()
        }
    }
}
