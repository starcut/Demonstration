import SwiftUI

struct PlaySoundView: View {
    @ObservedObject var viewModel: PlaySoundViewModel = PlaySoundViewModel()
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                self.viewModel.playSoundDingdong()
            } label: {
                Image(systemName: "circle")
                    .foregroundColor(Color.blue)
                    .font(.system(size: 80))
            }
            Spacer()
            Button {
                self.viewModel.playSoundFailure()
            } label: {
                Image(systemName: "multiply")
                    .foregroundColor(Color.red)
                    .font(.system(size: 80))
            }
            Spacer()
        }
    }
}
