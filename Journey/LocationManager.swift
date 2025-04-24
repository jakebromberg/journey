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
    private var isTracking: Bool = false
    @Published var locations: [CLLocation] = []

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    func start() {
        locationManager.startMonitoringSignificantLocationChanges()
        isTracking = true
    }

    func stop() {
        locationManager.stopMonitoringSignificantLocationChanges()
        isTracking = false
    }

    func reset() {
        locations.removeAll()
        isTracking = false
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.locations.isEmpty || isTracking || !self.locations.ranges(of: locations).isEmpty {
            self.locations.append(contentsOf: locations)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Handle authorization status changes if needed
    }
}
