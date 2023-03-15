import SwiftUI

struct TextNumberView: View {
    var body: some View {
        let number = 1234567890
        Text("\\ (number)で表示する：\(number)")
        Text("String型で表示する：\(String(number))")
    }
}
