import AVFoundation
import Foundation
import UIKit

class QrScanViewModel: NSObject, ObservableObject {
    @Published var isShownDialog = false
    @Published private(set) var qrString = ""
    
    var previewView: UIView = UIView()
    private let metadataOutput = AVCaptureMetadataOutput()
    private var session: AVCaptureSession?
    
    func launchQrcodeReader() {
        if let session = self.session {
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            return
        }
        
        let session = AVCaptureSession()
        guard let device = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back),
              let deviceInput = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            session.sessionPreset = .high
        default:
            session.sessionPreset = .photo
        }
        
        if session.canAddInput(deviceInput) {
            session.addInput(deviceInput)
        }
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
        }
        
        metadataOutput.metadataObjectTypes = [.qr]
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        DispatchQueue.main.async {
            let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer.videoGravity = .resizeAspectFill
            videoPreviewLayer.connection?.videoOrientation = .portrait
            videoPreviewLayer.frame = self.previewView.bounds
            self.previewView.layer.insertSublayer(videoPreviewLayer, at: 0)
        }
        
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
        
        self.session = session
    }
}

extension QrScanViewModel: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadataObject in metadataObjects {
            guard let machineReadableCode = metadataObject as? AVMetadataMachineReadableCodeObject,
                  machineReadableCode.type == .qr,
            let stringValue = machineReadableCode.stringValue else {
                return
            }
            self.qrString = stringValue
            self.isShownDialog = true
        }
    }
}

