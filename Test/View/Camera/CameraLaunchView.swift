//
//  CameraLaunch.swift
//  Test
//
//  Created by 清水脩輔 on 2023/08/03.
//

import SwiftUI

struct CameraLaunchView: View {
    @ObservedObject private var viewModel = CameraLaunchViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .padding()
                Text("P h o t o")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(Color.white)
                if viewModel.imageData.count > 0, let uiImage = UIImage(data: viewModel.imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
            }
            Button {
                viewModel.isLaunchedCamera.toggle()
            } label: {
                Text("カメラ起動")
            }
        }
        .fullScreenCover(isPresented: $viewModel.isLaunchedCamera) {
            Imagepicker(show: $viewModel.isLaunchedCamera,
                        image: $viewModel.imageData)
        }
    }
}
