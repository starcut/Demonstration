import Foundation
import LocalAuthentication

enum LoginStatus {
    case login
    case logout
}

final class TouchAuthViewModel: ObservableObject {
    @Published private(set) var loginStatus: LoginStatus = .logout
    
    var context: LAContext = LAContext()
    
    func auth() {
        context.localizedCancelTitle = "パスワード入力で認証する"
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print(error?.localizedDescription ?? "生体認証不可")
            return
        }
        
        let reason = "Face IDを使用する場合は設定より\nアクセスの許可を変更してください。"
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { isSuccess, error in
            if let error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.loginStatus = isSuccess ? .login : .logout
            }

            if isSuccess {
                print("認証成功")
            } else {
                print("認証失敗")
            }
        }
    }
}
