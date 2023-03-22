import SwiftUI

struct DatabaseListView: View {
    @ObservedObject var viewModel: DatabaseListViewModel = DatabaseListViewModel()
    
    @State var inputText: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                TextField("", text: self.$inputText)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                Button {
                    self.viewModel.registerData(inputText: self.inputText)
                    self.inputText = ""
                } label: {
                    Text("登録")
                }
                Spacer()
            }
            Spacer()
            List {
                ForEach(self.viewModel.data, id: \.self) { data in
                    VStack(alignment: .leading) {
                        Text("ID: \(data.id)")
                        Text("入力文字: \(data.title)")
                        Text("登録日: \(data.registerDate.transeJapaneseDateString())")
                        Text("更新日: \(data.updateDate.transeJapaneseDateString())")
                    }
                }
            }
        }
        .alert(isPresented: self.$viewModel.isShownDialog) {
            Alert(title: Text("Error"),
                  message: Text("登録に失敗しました"),
                  dismissButton: .default(Text("閉じる")))
        }
    }
}
