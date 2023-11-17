//
//  AVCaptureCameraView.swift
//  Test
//
//  Created by 清水脩輔 on 2023/08/04.
//

import SwiftUI

protocol CaptureCameraViewDelegate {
    func passImage(image: UIImage)
}

struct CaptureCameraView: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject private(set) var viewModel = CaptureCameraViewModel()
    
    var delegate: CaptureCameraViewDelegate?
    
    var body: some View {
        ZStack {
            CapturePreview(captureCameraViewModel: viewModel)
            VStack {
                Spacer()
                Button {
                    viewModel.capture()
                } label: {
                    Image(systemName: "circle.inset.filled")
                        .resizable(resizingMode: .stretch)
                        .foregroundColor(.white)
                }
                .frame(width: 60, height: 60)
            }
        }
        .onChange(of: viewModel.imageData) { imageData in
            guard let imageData = imageData else {
                return
            }
            delegate?.passImage(image: imageData)
            presentation.wrappedValue.dismiss()
        }
    }
}

struct CapturePreview: UIViewRepresentable {
    private var captureCameraViewModel: CaptureCameraViewModel
    
    init(captureCameraViewModel: CaptureCameraViewModel) {
        self.captureCameraViewModel = captureCameraViewModel
    }
    
    public func makeUIView(context: Context) -> some UIView {
        
        let cameraView = captureCameraViewModel.previewView
        cameraView.frame = UIScreen.main.bounds
        captureCameraViewModel.launchCamera()
        
        return cameraView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
