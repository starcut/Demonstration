import Foundation

class StepperViewModel: ObservableObject {
    @Published var bodyWeight: CGFloat = 60.0
    @Published var bodyHeight: CGFloat = 160.0
    @Published var bmi: CGFloat = 0.0
    
    func calcBmi() {
        bmi = bodyWeight / ((bodyHeight / 100) * (bodyHeight / 100))
    }
}
