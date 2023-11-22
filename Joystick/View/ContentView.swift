//
//  ContentView.swift
//  Joystick
//
//  Created by 김민재 on 11/17/23.
//

import SwiftUI
import SwiftUIJoystick
import MapKit

struct ContentView: View {
    @StateObject private var monitor = JoystickMonitor(width: 250)
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @StateObject private var locationPermission: LocationPermission = LocationPermission()

    var body: some View {
        ZStack {
            Map(initialPosition: position) {
                UserAnnotation()
            }
            .mapStyle(.standard(elevation: .realistic))
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            VStack {
                Spacer()
                Text("XY Point = (x: \(monitor.xyPoint.x.formattedString), y: \(monitor.xyPoint.y.formattedString))")
                    .fixedSize()
                Text("Polar Point = (radians: \(monitor.polarPoint.degrees.formattedString), y: \(monitor.polarPoint.distance.formattedString))")
                    .fixedSize()
                Joystick(monitor: monitor, width: 250, shape: .circle)
            }
        }
        .onAppear() {
            locationPermission.requestLocationPermission()
        }
    }
}

public extension CGFloat {
    var formattedString: String {
        String(format: "%.2f", self)
    }
}

#Preview {
    ContentView()
}
