import SwiftUI

struct SpeechView: View {
    @ObservedObject var viewModel: SpeechViewModel = SpeechViewModel()
    
    @FocusState private var focus: Bool
    
    var body: some View {
        VStack {
            Spacer()
            TextEditor(text: self.$viewModel.speechText)
                .focused(self.$focus)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            Spacer()
            Button {
                self.viewModel.readText()
            } label: {
                Text("読み上げ")
            }
            Spacer()
        }
        .onTapGesture {
            self.focus = false
        }
    }
}
