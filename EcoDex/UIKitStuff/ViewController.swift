// This code imports the necessary frameworks and creates a CLLocationManager object to manage location services. It also defines a PhotoWithLocation struct that stores an image of a plant, the plant's name, and the location where the photo was taken.

import AVFoundation
import UIKit
import CoreLocation


let locationMgr = CLLocationManager()

struct PhotoWithLocation {
    let image: UIImage
    let plantName: String
    let location: CLLocation
}

// This code defines a protocol ResultViewControllerDelegate that allows the ResultViewController to communicate with the ViewController class. It also defines the ViewController class, which is the main view controller of the app.

protocol ResultViewControllerDelegate: AnyObject {
    func retakePhoto(resultViewController: ResultViewController)
}


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
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColor.systemMint
        return button
    }()


    //  These methods are called when the view controller is loaded or appears on screen. The viewDidLoad() method sets up the view and user interface, while the viewDidAppear(_:) method starts the camera session.
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            startCameraSession()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemMint
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        view.addSubview(plantNameLabel)
        
        NSLayoutConstraint.activate([
            plantNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plantNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        checkCameraPermissions()
        
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.delegate = self
        locationMgr.desiredAccuracy = kCLLocationAccuracyBest
        locationMgr.startUpdatingLocation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 100)
    }
    
    var currentLocation: CLLocation?

    
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
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.session?.startRunning()
        }
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
                    DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            let resultViewController = ResultViewController()
                            resultViewController.capturedImage = image
                            resultViewController.plantName = plantName
                            resultViewController.delegate = self
                            resultViewController.currentLocation = self.currentLocation // Set the currentLocation property
                            self.present(resultViewController, animated: true, completion: nil)
                        }
                }
            } catch {
                print("Error while parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
        
    }
    
}

//  This extension implements the AVCapturePhotoCaptureDelegate protocol to handle capturing and processing photos from the camera.

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            return
        }


        identifyPlant(with: image)
    }
}


extension ViewController: ResultViewControllerDelegate {
    func retakePhoto(resultViewController: ResultViewController) {
        startCameraSession()
    }
}

class ResultViewController: UIViewController {
    
    var capturedImage: UIImage?
    var resultImage: UIImage?
    var plantName: String?
    var currentLocation: CLLocation?
    weak var delegate: ResultViewControllerDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let plantNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(named: "TertiaryTheme")
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
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(savePhoto), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = UIColor(named: "ThemeColor")
            imageView.image = capturedImage
            imageView.contentMode = .scaleAspectFit // Set the content mode to scaleAspectFit
            plantNameLabel.text = plantName
            
            view.addSubview(imageView)
            view.addSubview(plantNameLabel)
            view.addSubview(retakeButton)
            view.addSubview(saveButton)
            
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40) // adjust the constant as needed
        ])

            
            NSLayoutConstraint.activate([
                plantNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                plantNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                plantNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
            
            retakeButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                retakeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75),
                retakeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            ])
            
            saveButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
                saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            ])
            
            saveButton.addTarget(self, action: #selector(savePhoto), for: .touchUpInside)
            
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
            swipeDown.direction = .down
            view.addGestureRecognizer(swipeDown)
        }
    private func setupUI() {
            view.addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        }
    
    @objc private func handleSwipeDown() {
        dismiss(animated: true) {
            self.delegate?.retakePhoto(resultViewController: self)
        }
    }
    
    @objc private func retakePhoto() {
        dismiss(animated: true) {
            self.delegate?.retakePhoto(resultViewController: self)
        }
    }
    
    var photoWithLocationArray: [PhotoWithLocation] = []
    
    @objc private func savePhoto() {
        // Save photo, plant name, and location to a data structure, e.g. an array
        // You can create a global variable or use other methods to store the data
        
        // Example: save to an array of PhotoWithLocation objects
        if let image = capturedImage,
           let plantName = plantName,
           let location = currentLocation {
            let photoWithLocation = PhotoWithLocation(image: image, plantName: plantName, location: location)
            
            // Append the photoWithLocation to the array
            photoWithLocationArray.append(photoWithLocation)
            
            // Print the array's contents for debugging purposes
            print("Array contents:")
            for item in photoWithLocationArray {
                print("Image: \(item.image), Plant name: \(item.plantName), Location: \(item.location)")
            }
            
            // Dismiss the view controller and return to the camera
            dismiss(animated: true) {
                    self.delegate?.retakePhoto(resultViewController: self)
                }
        }
    }
    
}

//  This extension implements the CLLocationManagerDelegate protocol to handle location updates from the CLLocationManager.

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        }
    }
