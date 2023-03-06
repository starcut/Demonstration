import SwiftUI

struct TimerView: View {
    
    @ObservedObject var viewModel: TimerViewModel
    
    init() {
        self.viewModel = TimerViewModel(defaultTimeLimit: 60)
    }
    
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
            Text("\(String(format: "%.3f", self.viewModel.timeLimit))")
                .frame(width: 200, alignment: Alignment.leading)
                .font(.system(size: 60))
                .onChange(of: self.viewModel.isCountDown) { isCountDown in
                    if isCountDown {
                        self.viewModel.startTimer()
                    } else {
                        self.viewModel.pauseTimer()
                    }
                }
            Spacer()
            Toggle("開始/停止", isOn: self.$viewModel.isCountDown)
                .frame(width: 180)
            Spacer()
            Button {
                self.viewModel.timeLimit = 60
            } label: {
                Text("リセット")
            }
            Spacer()
        }
    }
}
