import SwiftUI

struct QrScanView: View {
    @ObservedObject private(set) var viewModel = QrScanViewModel()
    
    var body: some View {
        ZStack {
            QrCapturePreview(qrScanViewModel: viewModel)
            qrFrame()
            qrScanableArea()
            DialogView()
        }
        .frame(width: viewModel.cameraArea.width,
               height: viewModel.cameraArea.height)
    }
    
    private func qrFrame() -> some View {
        return Path { path in
            for readQrcodeArea in viewModel.readQrcodeArea {
                path.move(to: readQrcodeArea[0])
                for (index, _) in readQrcodeArea.enumerated() {
                    let readIndex = (index + 1) % readQrcodeArea.count
                    path.addLine(to: readQrcodeArea[readIndex])
                }
            }
        }
        .stroke(lineWidth: 4)
        .fill(Color.green)
    }
    
    private func qrScanableArea() -> some View {
        return ZStack {}
            .frame(width: viewModel.detectArea.width,
                   height: viewModel.detectArea.height)
            .border(.red, width: 2)
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
