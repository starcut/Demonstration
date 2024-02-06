import SwiftUI

struct StepperView: View {
    @ObservedObject private var viewModel = StepperViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("体重")
                Stepper(value: $viewModel.bodyWeight, step: 0.1) {
                    Text("\(viewModel.bodyWeight, specifier: "%.1f") kg")
                }
                Spacer()
            }
            HStack {
                Spacer()
                Text("身長")
                Stepper(value: $viewModel.bodyHeight, step: 0.1) {
                    Text("\(viewModel.bodyHeight, specifier: "%.1f") cm")
                }
                Spacer()
            }
            HStack {
                Text("BMI: \(viewModel.bmi)")
            }
            Button {
                viewModel.calcBmi()
            } label: {
                Text("BMIを計算する")
            }
        }
    }
}
