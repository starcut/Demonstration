import SwiftUI

struct ApplicationNotificationView: View {
    var body: some View {
        ZStack {
            Text("アプリ起動などの通知")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { notification in
            print("--------didBecomeActiveNotification--------")
            print("アクティブになった。")
            print("--------didBecomeActiveNotification--------")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { notification in
            print("--------willResignActiveNotification--------")
            print("非活性になるよ。")
            print("--------willResignActiveNotification--------")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { notification in
            print("--------didEnterBackgroundNotification--------")
            print("バックグランドになった。")
            print("--------didEnterBackgroundNotification--------")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { notification in
            print("--------willEnterForegroundNotification--------")
            print("フォアグラウンドになるよ。")
            print("--------willEnterForegroundNotification--------")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { notification in
            print("--------willTerminateNotification--------")
            print("アプリ終了するよ。")
            print("--------willTerminateNotification--------")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            print("--------UIDevice.orientationDidChangeNotification--------")
            print("画面が回転したよ")
            print("--------UIDevice.orientationDidChangeNotification--------")
        }
    }
}
