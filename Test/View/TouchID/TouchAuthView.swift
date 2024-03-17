import SwiftUI

struct TouchAuthView: View {
    
    @ObservedObject private var viewModel = TouchAuthViewModel()
    
    var body: some View {
        VStack {
            if viewModel.loginStatus == .logout {
                loginView()
            } else {
                mainView()
            }
        }
    }
    
    func loginView() -> some View {
        return VStack {
            Button {
                viewModel.auth()
            } label: {
                Text("認証開始")
            }
        }
    }
    
    func mainView() -> some View {
        return VStack {
            Text("メイン画面")
        }
    }
}
