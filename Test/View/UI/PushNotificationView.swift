import SwiftUI

struct PushNotificationView: View {
    @ObservedObject private var viewModel = PushNotificationViewModel()
    
    var body: some View {
        Button {
            viewModel.notification()
        } label: {
            Text("プッシュ通知を表示させる")
        }
    }
}
