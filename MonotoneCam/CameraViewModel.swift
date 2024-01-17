import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, ObservableObject {
    private let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private var videoDeviceInput: AVCaptureDeviceInput!

    let previewLayer = AVCaptureVideoPreviewLayer()

    func configure() {
        checkPermissions()
        setupSession()
        startSession()
    }

    private func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break // already authorized
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if !granted {
                    // handle denied access
                }
            }
        default:
            // handle denied access
            break
        }
    }

    private func setupSession() {
        session.beginConfiguration()
        defer { session.commitConfiguration() }

        // カメラデバイスの設定
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              session.canAddInput(videoDeviceInput) else {
            return
        }
        session.addInput(videoDeviceInput)
        self.videoDeviceInput = videoDeviceInput

        // 写真出力の設定
        guard session.canAddOutput(photoOutput) else { return }
        session.addOutput(photoOutput)
    }

    private func startSession() {
        session.startRunning()
        previewLayer.session = session
        previewLayer.videoGravity = .resizeAspectFill
    }

    func takePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = .auto
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
}

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // 写真の処理
    }
}
