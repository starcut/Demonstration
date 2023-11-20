import SwiftUI

struct CallZipCodeView: View {
    @ObservedObject private var viewModel = CallZipCodeViewModel()
    @FocusState private var focusState: Bool
    
    var body: some View {
        VStack {
            Text("郵便番号を入力してください")
            Text("（ハイフン不要）")
            TextField("郵便番号", text: $viewModel.zipCode)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .textFieldStyle(.roundedBorder)
                .focused($focusState)
                .keyboardType(.numberPad)
            Button {
                viewModel.pushedSearchButton()
            } label: {
                Text("郵便番号取得")
            }
            TextEditor(text: $viewModel.jsonData)
                .disabled(true)
        }
        .onTapGesture {
            focusState = false
        }
    }
}
