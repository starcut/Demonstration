import SwiftUI

struct TransScreenSecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var text: String
    var backgroundColor: Color
    var isFullScreen: Bool?
    
    init(text: String, backgroundColor: Color, isFullScreen: Bool? = nil) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.isFullScreen = isFullScreen
    }
    
    var body: some View {
        ZStack {
            backgroundColor
            VStack {
                Spacer()
                Text("\(text)")
                Spacer()
                if isFullScreen ?? false {
                    Button {
                        dismiss()
                    } label: {
                        Text("元の画面に戻る")
                    }
                    Spacer()
                }
            }
        }
    }
}
