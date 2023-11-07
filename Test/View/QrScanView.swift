import SwiftUI

struct QrScanView: View {
    @ObservedObject private(set) var viewModel = QrScanViewModel()
    
    var body: some View {
        ZStack {
            QrCapturePreview(qrScanViewModel: viewModel)
            VStack {
                Spacer()
            }
            DialogView()
        }
    }
    
    private func DialogView() -> some View {
        return ZStack {
            Text("")
                .alert(isPresented: $viewModel.isShownDialog) {
                    Alert(title: Text("読み取ったQRコード"),
                          message: Text(viewModel.qrString),
                          dismissButton: .default(Text("閉じる")) {}
                    )
                }
        }
    }
}

struct QrCapturePreview: UIViewRepresentable {
    private var qrScanViewModel: QrScanViewModel
    
    init(qrScanViewModel: QrScanViewModel) {
        self.qrScanViewModel = qrScanViewModel
    }
    
    public func makeUIView(context: Context) -> some UIView {
        
        let cameraView = qrScanViewModel.previewView
        cameraView.frame = UIScreen.main.bounds
        
        self.qrScanViewModel.launchQrcodeReader()
        
        return cameraView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
