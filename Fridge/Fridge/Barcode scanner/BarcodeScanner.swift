import SwiftUI
import AVFoundation

struct BarcodeScanner: View, BarcodeScannerParameters {
    let camera: CameraViewModel

    var body: some View {
        ZStack {
            CameraPreview(cameraVM: camera)
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.white, lineWidth: 3)
                .frame(width: recognizableAreaWidth, height: recognizableAreaHeight)
        }
    }
}

struct CameraPreview: UIViewRepresentable, BarcodeScannerParameters {
    private var camera: CameraViewModel

    init(cameraVM: CameraViewModel) {
        camera = cameraVM
    }

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        camera.session.startRunning()
        camera.output.rectOfInterest = camera.preview.metadataOutputRectConverted(fromLayerRect: recognizableAreaRect)
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

struct BarcodeScanner_Previews: PreviewProvider {
    @State static var code: String? = ""

    static var previews: some View {
        BarcodeScanner(camera: CameraViewModel())
    }
}
