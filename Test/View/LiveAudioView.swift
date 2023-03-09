import SwiftUI
import AVFoundation

struct LiveAudioView: View {
    @ObservedObject var viewModel: LiveAudioViewModel = LiveAudioViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                if self.viewModel.voiceText == "" {
                    Text("ここに入力した文字列が表示されます")
                } else {
                    Text(self.viewModel.voiceText)
                }
            }
            Spacer()
            Button {
                self.viewModel.toggleRecording()
            } label: {
                Image(systemName: self.viewModel.audioRunning ? "stop.circle" : "record.circle")
                    .font(.system(size: 120))
                    .foregroundColor(self.viewModel.audioRunning ? Color.black : Color.red)
            }
        }
    }
}
