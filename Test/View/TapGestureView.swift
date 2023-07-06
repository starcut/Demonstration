import SwiftUI

struct TapGestureView: View {
    @ObservedObject private var viewModel = TapGestureViewModel()
    
    @State var textColor: Color = .black
    @State var iconTapCount: Int = 0
    
    let cellImage = Image(systemName: "bell.square")
    var gradientLayer = CAGradientLayer()
    
    var body: some View {
        VStack {
            Spacer()
            Text("セルを表示しているよ")
                .frame(width: 240, height: 100)
                .border(textColor)
                .foregroundColor(textColor)
                .onTapGesture {
                    iconTapCount += 1
                    switch iconTapCount % 5 {
                    case 0:
                        textColor = .red
                    case 1:
                        textColor = .blue
                    case 2:
                        textColor = .green
                    case 3:
                        textColor = .yellow
                    case 4:
                        textColor = .black
                    default:
                        textColor = .black
                    }
                }
            Spacer()
            cellImage
                .resizable(resizingMode: .stretch)
                .frame(width: 100, height: 100)
                .foregroundColor(viewModel.imageColor)
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 20) {
                    print("長押し処理")
                    viewModel.timerFiring()
                } onPressingChanged: { isPress in
                    if isPress {
                        print("押されてからminimumDurationの時間が経つまで")
                        viewModel.stopTimer()
                    } else {
                        print("minimumDurationだけ時間が経った")
                    }
                }
            Spacer()
        }
    }
}
