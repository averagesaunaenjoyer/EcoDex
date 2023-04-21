import SwiftUI

struct CameraView: UIViewControllerRepresentable {
   
    func makeUIViewController(context: Context) -> ViewController {
        let viewController = ViewController()
        return viewController
    }
   
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Leave this empty for now
    }
}
