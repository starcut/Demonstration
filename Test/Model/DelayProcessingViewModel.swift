import Foundation

class DelayProcessingViewModel: ObservableObject {
    @Published var isDisplayText = false
    
    func pushedButton() {
        let interval: TimeInterval = 3
        DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: {
            self.isDisplayText = true
        })
    }
}
