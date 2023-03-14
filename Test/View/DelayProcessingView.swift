import SwiftUI

struct DelayProcessingView: View {
    @ObservedObject var viewModel: DelayProcessingViewModel = DelayProcessingViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            if self.viewModel.isDisplayText {
                Text("ボタン押されてから時間が経ったよ")
            }
            Spacer()
            Button {
                self.viewModel.pushedButton()
            } label: {
                Text("3秒後に文字が表示されるボタン")
            }
            Spacer()
        }
    }
}
