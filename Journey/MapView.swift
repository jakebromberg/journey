//
//  MapView.swift
//  Journey
//
//  Created by Jake Bromberg on 4/24/25.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var locations: [CLLocation]

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        map.showsUserLocation = true
        return map
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = locations.map { location -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            annotation.title = formatter.string(from: location.timestamp)
            return annotation
        }
        mapView.addAnnotations(annotations)
        if let last = locations.last {
            let region = MKCoordinateRegion(center: last.coordinate,
                                            latitudinalMeters: 500,
                                            longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate { }
}
