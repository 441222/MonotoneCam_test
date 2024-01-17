import SwiftUI
import AVFoundation

struct CameraView: View {
    @EnvironmentObject var cameraViewModel: CameraViewModel

    var body: some View {
        ZStack {
            CameraPreview(camera: cameraViewModel)
                .onAppear {
                    cameraViewModel.configure()
                }

            // シャッターボタン
            VStack {
                Spacer()
                Button(action: {
                    cameraViewModel.takePhoto()
                }) {
                    Image(systemName: "camera")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .foregroundColor(.black)
                }
                .padding(.bottom)
            }
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraViewModel

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.previewLayer.frame = view.frame
        view.layer.addSublayer(camera.previewLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // ビューが更新されたときの処理
    }
}
