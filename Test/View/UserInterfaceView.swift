import SwiftUI

struct UserInterfaceView: View {
    @State private var inputText: String = ""
    @State private var inputEditorString: String = ""
    
    var body: some View {
        Text("境界、それはものとものの境目")
            .border(Color.gray, width: 3)
        Text("斜め\n七十七度の\n並びで\n泣く泣くいななく\nナナハン\n七台\n難なく\n並べて\n長眺め\n左上から右下へ")
            .border(LinearGradient(gradient: Gradient(colors: [.green, .blue]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing),
                    width: 3)
        
        TextField("入力してください、色々と", text: self.$inputText)
            .textFieldStyle(.roundedBorder)
        
        TextEditor(text: self.$inputEditorString)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
    }
}
