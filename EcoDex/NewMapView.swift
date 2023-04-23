//
//  NewMapView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/22/23.
//

import SwiftUI
import MapKit
import Combine
import CoreLocation

// Model struct for your data
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct NewMapView: UIViewRepresentable {
    
    @State private var locations: [Location] = [
        Location(name: "Location 1", coordinate: CLLocationCoordinate2D(latitude: 34.070211, longitude: -118.446775)),
        Location(name: "Location 2", coordinate: CLLocationCoordinate2D(latitude: 34.070345, longitude: -118.447012)),
        Location(name: "Location 3", coordinate: CLLocationCoordinate2D(latitude: 34.070123, longitude: -118.446543)),
    ]
    private var counter = 0
    private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.070211, longitude: -118.446775), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @EnvironmentObject private var mapSettings: MapSettings

    let locationManager = CLLocationManager()

    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // Permission granted, start updating location
            locationManager.startUpdatingLocation()
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.showsUserLocation = true
        mapView.region = mapRegion
        
        locationManager.delegate = MapViewCoordinator(self)
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Create location annotations from the array of locations
        let annotations = locations.map { LocationAnnotation(location: $0) }

        // Add the annotations to the map
        mapView.addAnnotations(annotations)

        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateMapType(uiView)
    }
    
    private func updateMapType(_ uiView: MKMapView) {
        switch mapSettings.mapType {
        case 0:
            uiView.preferredConfiguration = MKImageryMapConfiguration(elevationStyle: elevationStyle())
        case 1:
            uiView.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: elevationStyle())
        case 2:
            uiView.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: elevationStyle())
        default:
            break
        }
        
    }
    
    private func elevationStyle() -> MKMapConfiguration.ElevationStyle {
        if mapSettings.showElevation == 0 {
            return MKMapConfiguration.ElevationStyle.realistic
        } else {
            return MKMapConfiguration.ElevationStyle.flat
        }
    }
    
    private func emphasisStyle() -> MKStandardMapConfiguration.EmphasisStyle {
        if mapSettings.showEmphasisStyle == 0 {
            return MKStandardMapConfiguration.EmphasisStyle.default
        } else {
            return MKStandardMapConfiguration.EmphasisStyle.muted
        }
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
    var parent: NewMapView
    
    init(_ parent: NewMapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard let location = userLocation.location else { return }
        
        // Do something with the user's location here
        print(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}

class LocationAnnotation: NSObject, MKAnnotation {
    let location: Location
    
    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }
    
    var title: String? {
        return location.name
    }
    
    init(location: Location) {
        self.location = location
    }
}

