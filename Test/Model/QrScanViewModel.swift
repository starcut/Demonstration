import AVFoundation
import Foundation
import UIKit

class QrScanViewModel: NSObject, ObservableObject {
    @Published var isShownDialog = false
    @Published private(set) var qrString = ""
    @Published private(set) var readQrcodeArea: [[CGPoint]] = []
    
    var previewView: UIView = UIView()
    let cameraArea: CGSize
    
    private let metadataOutput = AVCaptureMetadataOutput()
    private let qrDetectAreaSize: CGFloat = 200.0
    private(set) var detectArea: CGRect
    
    private var session: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer
    
    override init() {
        self.cameraArea = CGSize(width: UIScreen.main.bounds.width - 80,
                                height: UIScreen.main.bounds.height - 180)
        self.detectArea = CGRect(x: (cameraArea.width - qrDetectAreaSize) * 0.5,
                                 y: (cameraArea.height - qrDetectAreaSize) * 0.5,
                                 width: qrDetectAreaSize,
                                 height: qrDetectAreaSize)
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer()
        
        super.init()
    }
    
    func launchQrcodeReader() {
        if let session = self.session {
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            return
        }
        
        let session = AVCaptureSession()
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
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
        showCameraView(session: session)
        
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
        
        self.session = session
    }
    
    private func showCameraView(session: AVCaptureSession) {
        DispatchQueue.main.async {
            self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            self.videoPreviewLayer.videoGravity = .resizeAspectFill
            self.videoPreviewLayer.connection?.videoOrientation = .portrait
            self.videoPreviewLayer.frame = self.previewView.bounds
            let metadataOutputRectOfInterest = CGRect(x: self.detectArea.minY / self.cameraArea.height ,
                                                      y: self.detectArea.minX / self.cameraArea.width,
                                                      width: self.detectArea.height / self.cameraArea.height,
                                                      height: self.detectArea.width / self.cameraArea.width)
            self.metadataOutput.rectOfInterest = metadataOutputRectOfInterest
            self.previewView.layer.insertSublayer(self.videoPreviewLayer, at: 0)
        }
    }
}

extension QrScanViewModel: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        self.readQrcodeArea.removeAll()
        
        for metadataObject in metadataObjects {
            guard let machineReadableCode = metadataObject as? AVMetadataMachineReadableCodeObject,
                  machineReadableCode.type == .qr,
            let stringValue = machineReadableCode.stringValue else {
                return
            }
            guard let transformedObject = self.videoPreviewLayer.transformedMetadataObject(for: metadataObject) as? AVMetadataMachineReadableCodeObject else {
                return
            }
            self.readQrcodeArea.append(transformedObject.corners)
            self.qrString = stringValue
//            self.isShownDialog = true
        }
    }
}

