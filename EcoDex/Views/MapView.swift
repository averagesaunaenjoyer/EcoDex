//
//  MapView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/22/23.
//

import MapKit
import SwiftUI

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    
    let annotations = [
        Place(name: "Court of Sciences", coordinate: CLLocationCoordinate2D(latitude: 34.06848, longitude: -118.44224)),
        Place(name: "Westwood Village", coordinate: CLLocationCoordinate2D(latitude: 34.05945, longitude: -118.44425)),
        Place(name: "Anderson", coordinate: CLLocationCoordinate2D(latitude: 34.07398, longitude: -118.4437))
    ]
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: annotations) { place in
            MapAnnotation(coordinate: place.coordinate) {
                HStack {
                    Image(systemName: "tree.fill")
                        .foregroundColor(Color(.systemMint))
                }
                .padding(5)
                .background(Color(.white))
                .cornerRadius(100)
                .frame(width: 10, height: 10)
            }
        }
            .ignoresSafeArea()
            .accentColor(Color(.systemMint))
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion()
    
    var locationManager: CLLocationManager?
    
    override init() {
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.070211, longitude: -118.446775), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            super.init()
            checkIfLocationServicesIsEnabled()
        }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.requestWhenInUseAuthorization()
        } else {
            print("Location services off...")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted most likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Change this in settings")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
