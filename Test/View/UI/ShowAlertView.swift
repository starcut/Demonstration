import SwiftUI

struct ShowAlertView: View {
    @ObservedObject var viewModel: ShowAlertViewModel = ShowAlertViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Button {
                    self.viewModel.isDefaultDialogPresented = true
                } label: {
                    Text("閉じるボタンのみのアラートを表示する")
                }
                Spacer()
                Button {
                    self.viewModel.isDeleteDialogPresented = true
                } label: {
                    Text("削除ボタンのアラートを表示する")
                }
                Spacer()
            }
            DialogView()
        }
    }
    
    private func DialogView() -> some View {
        return ZStack {
            Text("")
                .alert(isPresented: self.$viewModel.isDefaultDialogPresented) {
                    Alert(title: Text("閉じるボタンのみアラート表示のタイトル"),
                          message: Text("閉じるボタンのみアラート本文"),
                          dismissButton: .default(Text("閉じる")) {
                        print("閉じます")
                    })
                }
            Text("")
                .alert(isPresented: self.$viewModel.isDeleteDialogPresented) {
                    Alert(title: Text("削除アラート表示のタイトル"),
                          message: Text("削除アラート本文"),
                          primaryButton: .cancel(Text("キャンセル")) {
                        print("キャンセルします")
                    },
                          secondaryButton: .destructive(Text("削除")) {
                        print("削除します")
                    })
                }
        }
    }
}
