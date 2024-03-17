import SwiftUI
import Zxcvbn

struct SecurityPasswordView: View {
    @State var password: String = ""
    @State private var isBlankPassword: Bool = true
    @State private var securityMessage: String = "パスワード強度：無"
    @State private var meterColor: Color = .red
    
    private let passwordPlaceholder: String = "パスワード"
    
    var body: some View {
        ZStack {
            if #available(iOS 17.0, *) {
                passwordView()
                    .onChange(of: password) { _, password in
                        passwordStrengthConfigure(password: password)
                    }
            } else {
                passwordView()
                    .onChange(of: password) { password in
                        passwordStrengthConfigure(password: password)
                    }
            }
        }
    }
    
    private func passwordStrengthConfigure(password: String) {
        switch password.zxcvbn(custom: []).score {
        case .none:
            securityMessage = "パスワード強度：無"
            meterColor = .red
        case .insufficient:
            securityMessage = "パスワード強度：かなり弱い"
            meterColor = .red
        case .weak:
            securityMessage = "パスワード強度：弱い"
            meterColor = .orange
        case .sufficient:
            securityMessage = "パスワード強度：普通"
            meterColor = .green
        case .strong:
            securityMessage = "パスワード強度：強い"
            meterColor = .blue
        }
    }
    
    private func passwordView() -> some View {
        return VStack(alignment: .leading) {
            Text("パスワード")
            HStack {
                if isBlankPassword {
                    SecureField(passwordPlaceholder, text: $password)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.asciiCapable)
                } else {
                    TextField(passwordPlaceholder, text: $password)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.asciiCapable)
                }
                Toggle(isOn: $isBlankPassword) {
                    Image(systemName: isBlankPassword ? "eye.slash.fill" : "eye.fill")
                }
                .toggleStyle(.button)
            }
            HStack {
                ForEach(Result.Score.allCases) { score in
                    if score > .none {
                        Rectangle()
                            .foregroundColor(password.zxcvbn(custom: []).score < score ? Color.secondary.opacity(0.4) : meterColor)
                            .frame(height: 10)
                    }
                }
            }
            Text(securityMessage)
        }
        .padding()
    }
}
