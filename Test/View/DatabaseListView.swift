import SwiftUI

struct DatabaseListView: View {
    @ObservedObject var viewModel: DatabaseListViewModel = DatabaseListViewModel()
    
    @State var inputText: String = ""
    @State var updateText: String = ""
    
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
                    .swipeActions(edge: .trailing) {
                        HStack {
                            Button {
                                self.viewModel.deleteData(data: data)
                            } label: {
                                ZStack {
                                    Color.red
                                    Text("削除")
                                        .foregroundColor(Color.white)
                                }
                            }
                            Button {
                                self.viewModel.isShownDialog = true
                            } label: {
                                ZStack {
                                    Color.blue
                                    Text("更新")
                                        .foregroundColor(Color.white)
                                }
                            }
                        }
                    }
                    .alert("文字列を入力してください", isPresented: self.$viewModel.isShownDialog) {
                        TextField("文字列", text: self.$updateText)
                        Button("Ok", role: .cancel){
                            self.viewModel.updateData(data: data, inputText: self.updateText)
                            self.updateText = ""
                        }
                    }
                }
            }
        }
    }
}
