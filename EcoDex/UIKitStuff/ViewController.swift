import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    // Capture Session
    var session: AVCaptureSession?
    
    // Photo Output
    let output = AVCapturePhotoOutput()
    // Video Preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    // Plant Name Label
    private let plantNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Shutter Button
    private let shutterButton: UIButton = {
         let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
         button.layer.cornerRadius = 50
         button.layer.borderWidth = 10
         button.layer.borderColor = UIColor.systemMint.cgColor
         return button
     }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        view.addSubview(plantNameLabel)
        
        NSLayoutConstraint.activate([
            plantNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plantNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        checkCameraPermissions()
        
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 100)
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video ) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                self.session = session
                
            }
            catch {
                print(error)
            }
        }
    }
    
    @objc private func didTapTakePhoto() {
        UIView.animate(withDuration: 0.1, animations: {
            self.shutterButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.shutterButton.transform = CGAffineTransform.identity
            }) { (_) in
                self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            }
        }
    }
    
    func startCameraSession() {
            session?.startRunning()
        }
    
    private func identifyPlant(with image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }

        let base64Image = imageData.base64EncodedString()

        let apiKey = "u7rXmBHwZ0Q9vGp4eY5eMJ3yuNkhRtOWjejMAaVz61kbtRtXwK"
        let urlString = "https://api.plant.id/v2/identify"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiKey, forHTTPHeaderField: "Api-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "organs": ["leaf"],
            "organs_quality": "good",
            "organs_number": 1,
            "images": [base64Image]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error while encoding request parameters: \(error.localizedDescription)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received.")
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let suggestions = jsonResponse["suggestions"] as? [[String: Any]],
                   let bestSuggestion = suggestions.first,
                   let plantName = bestSuggestion["plant_name"] as? String {
                    DispatchQueue.main.async {
                        let resultViewController = ResultViewController()
                        resultViewController.capturedImage = image
                        resultViewController.plantName = plantName
                        self?.present(resultViewController, animated: true, completion: nil)
                    }
                }
            } catch {
                print("Error while parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            return
        }

        session?.stopRunning()

        identifyPlant(with: image)
    }
}

class ResultViewController: UIViewController {
    
    var capturedImage: UIImage?
    var resultImage: UIImage?
    var plantName: String?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let plantNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let retakeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retake", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(retakePhoto), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        imageView.image = resultImage
        plantNameLabel.text = plantName
        
        view.addSubview(imageView)
        view.addSubview(plantNameLabel)
        view.addSubview(retakeButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            plantNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plantNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        retakeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            retakeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retakeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func retakePhoto() {
        dismiss(animated: true) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let delegate = windowScene.delegate as? SceneDelegate,
               let parentVC = delegate.window?.rootViewController as? ViewController {
                parentVC.startCameraSession()
            }
        }
    }

}
