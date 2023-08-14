//
//  CaptureCameraPrepareView.swift
//  Test
//
//  Created by 清水脩輔 on 2023/08/06.
//

import SwiftUI

struct CaptureCameraPrepareView: View {
    @ObservedObject private var viewModel = CaptureCameraPrepareViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .padding()
                    Text("P h o t o")
                        .font(.system(size: 30))
                        .bold()
                        .foregroundColor(Color.white)
                    if  let uiImage = viewModel.imageData {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                }
                NavigationLink {
                    CaptureCameraView(delegate: self)
                } label: {
                    Text("カメラ起動")
                }
            }
        }
    }
}

extension CaptureCameraPrepareView: CaptureCameraViewDelegate {
    func passImage(image: UIImage) {
        print(image)
        viewModel.imageData = image
    }
}
