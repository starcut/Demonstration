import SwiftUI

struct TransScreenView: View {
    @ObservedObject var viewModel: TransScreenViewModel = TransScreenViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    Button {
                        self.viewModel.isPresented = true
                    } label: {
                        Text("presentメソッドの画面遷移")
                    }
                    Spacer()
                    Button {
                        self.viewModel.isFullScreenPresented = true
                    } label: {
                        Text("presentメソッドの画面遷移FullScreen")
                    }
                    Spacer()
                    NavigationLink {
                        TransScreenSecondView(text: "pushの遷移", backgroundColor: Color.cyan)
                    } label: {
                        Text("pushメソッドの画面遷移")
                    }
                    Spacer()
                }
                .fullScreenCover(isPresented: self.$viewModel.isFullScreenPresented) {
                    TransScreenSecondView(text: "presentの遷移", backgroundColor: Color.green, isFullScreen: true)
                }
                .sheet(isPresented: self.$viewModel.isPresented) {
                    TransScreenSecondView(text: "presentの遷移", backgroundColor: Color.purple)
                }
            }
        }
    }
}
