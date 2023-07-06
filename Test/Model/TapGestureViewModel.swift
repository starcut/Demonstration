import Foundation
import SwiftUI

class TapGestureViewModel: ObservableObject {
    var red: Double = 1.0
    var green: Double = 0.0
    var blue: Double = 0.0
    var count: Int = 0
    var timer: Timer?
    
    @Published private(set) var imageColor: Color = Color.init(red: 1.0, green: 0.0, blue: 0.0)
    
    func timerFiring() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateColor), userInfo: nil, repeats: true)
    }

    @objc private func updateColor() {
        count = (count + 1) % 300
        switch count {
        case 0 ..< 50:
            red = 1.0
            green = 0.0
            blue = 0.0 + Double(count)/50.0
        case 50 ..< 100:
            red = 1.0 - Double(count-50)/50.0
            green = 0.0
            blue = 1.0
        case 100 ..< 150:
            red = 0.0
            green = 0.0 + Double(count-100)/50.0
            blue = 1.0
        case 150 ..< 200:
            red = 0.0
            green = 1.0
            blue = 1.0 - Double(count-150)/50.0
        case 200 ..< 250:
            red = 0.0 + Double(count-200)/50.0
            green = 1.0
            blue = 0.0
        case 250 ..< 300:
            red = 1.0
            green = 1.0 - Double(count-250)/50.0
            blue = 0.0
        default:
            red = 0.0
            green = 0.0
            blue = 0.0
        }
        imageColor = Color(red: red, green: green, blue: blue)
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}
