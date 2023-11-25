import SwiftUI

struct CallZipCodeView: View {
    @ObservedObject private var viewModel = CallZipCodeViewModel()
    @FocusState private var focusState: Bool
    
    var body: some View {
        ZStack {
            VStack {
                zipcodeView()
                resultTextField()
                jsonTextView()
            }
            if viewModel.isShownProgressView {
                progressView()
            }
        }
    }
    
    private func progressView() -> some View {
        return ZStack {
            Color.gray.opacity(0.2)
            ProgressView()
                .progressViewStyle(.circular)
                .padding()
                .tint(Color.white)
                .background(Color.black)
                .cornerRadius(8)
                .scaleEffect(1.2)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func zipcodeView() -> some View {
        return VStack {
            Text("郵便番号を入力してください")
            Text("（ハイフン不要）")
            TextField("郵便番号", text: $viewModel.zipCode)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .textFieldStyle(.roundedBorder)
                .focused($focusState)
                .keyboardType(.numberPad)
            Button {
                focusState = false
                viewModel.pushedSearchButton()
            } label: {
                Text("郵便番号取得")
            }
        }
        .onTapGesture {
            focusState = false
        }
    }
    
    private func resultTextField() -> some View {
        return VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .lastTextBaseline) {
                Text("〒")
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                TextField("郵便番号", text: $viewModel.zipText)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
                    .frame(width: 120)
            }
            Text("住所")
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
            TextField("住所", text: $viewModel.addressText)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
                .padding()
            Text("住所カナ")
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
            TextField("住所カナ", text: $viewModel.addressKana)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
                .padding()
        }
    }
    
    private func jsonTextView() -> some View {
        return VStack {
            TextEditor(text: $viewModel.jsonData)
                .disabled(true)
                .padding()
        }
    }
}
