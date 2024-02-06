import SwiftUI

struct InterfaceTestView: View {
    
    private var window: UIWindow? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        return windowScene?.windows.first
    }
    
    private var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat
        if #available(iOS 13.0, *) {
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    var body: some View {
        GeometryReader { geometry in
            Color.yellow
            VStack {
                Text("ステータスバーの高さ")
                Text("\(statusBarHeight)")
                
                Text("画面サイズ")
                Text("幅：\(UIScreen.main.bounds.width) 高さ：\(UIScreen.main.bounds.height)")
                
                Text("SafeArea")
                Text("上：\(window?.safeAreaInsets.top ?? 0)")
                Text("下：\(window?.safeAreaInsets.bottom ?? 0)")
                Text("左：\(window?.safeAreaInsets.left ?? 0)")
                Text("右：\(window?.safeAreaInsets.right ?? 0)")
                
                Text("SafeAresサイズ（黄色部分）")
                Text("幅：\(geometry.size.width) 高さ：\(geometry.size.height)")
            }
        }
    }
}
