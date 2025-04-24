//
//  Location Manager.swift
//  Journey
//
//  Created by Jake Bromberg on 4/24/25.
//

// Info.plist (add these keys to enable background location tracking)
/*
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>We need your location to track significant changes.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to track significant changes.</string>
<key>UIBackgroundModes</key>
<array>
    <string>location</string>
</array>
*/

// LocationManager.swift
import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var locations: [CLLocation] = []

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    func start() {
        locationManager.startMonitoringSignificantLocationChanges()
    }

    func stop() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }

    func reset() {
        locations.removeAll()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locations.append(contentsOf: locations)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Handle authorization status changes if needed
    }
}
