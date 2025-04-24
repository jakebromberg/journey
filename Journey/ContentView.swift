//
//  ContentView.swift
//  Journey
//
//  Created by Jake Bromberg on 4/24/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()
    @State private var isTracking = false

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if isTracking {
                        locationManager.stop()
                    } else {
                        locationManager.start()
                    }
                    isTracking.toggle()
                }) {
                    Image(systemName: isTracking ? "pause.circle.fill" : "play.circle.fill")
                        .font(.largeTitle)
                }
                .padding()

                Button(action: {
                    locationManager.reset()
                }) {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .font(.largeTitle)
                }
                .padding()
            }

            MapView(locations: $locationManager.locations)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
