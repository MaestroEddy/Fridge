import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    var session = AVCaptureSession()
    var output = AVCaptureMetadataOutput()
    var preview = AVCaptureVideoPreviewLayer()
    var recognizedCodeBlock: ((String) -> ())?
    var code: Binding<String>?

    override init() {
        super.init()
        setup()
    }

    private func setup() {
        session.beginConfiguration()
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input),
              session.canAddOutput(output) else {
            assertionFailure()
            return
        }
        session.addInput(input)
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: .global())
        output.metadataObjectTypes = [.qr, .ean13, .code128]
        session.commitConfiguration()
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {

        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let stringValue = readableObject.stringValue else { return }
        code?.wrappedValue = stringValue
    }
}
