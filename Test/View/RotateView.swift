import SwiftUI

struct RotateView: View {
    @ObservedObject var viewModel: RotateViewModel
    
    init() {
        self.viewModel = RotateViewModel()
    }
    
    var body: some View {
        VStack {
            Text(self.viewModel.screenOrientation)
                .font(.system(size: 20))
            HStack {
                Spacer()
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.viewModel.rotateClockWiseScreen()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20))
                }
                Spacer()
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.viewModel.unRockScreenOrientation()
                    }
                } label: {
                    Image(systemName: "lock.open")
                        .font(.system(size: 20))
                }
                Spacer()
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.viewModel.rotateCounterClockWiseScreen()
                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 20))
                }
                Spacer()
            }
        }
        .onAppear {
            AppDelegate.orientationLock = .all
        }
    }
}
