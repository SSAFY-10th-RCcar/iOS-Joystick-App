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
    @StateObject private var monitor = JoystickMonitor()
    @State private var position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.501273, longitude: 127.039614),
                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
            )
        )

    var body: some View {
        ZStack {
            Map(position: $position) {
                UserAnnotation()
            }
            Circle()
                .fill(Color.red)
                .frame(width: 16, height: 16)
            VStack {
                Spacer()
                Text("XY Point = (x: \(monitor.xyPoint.x.formattedString), y: \(monitor.xyPoint.y.formattedString))")
                    .fixedSize()
                Text("Polar Point = (radians: \(monitor.polarPoint.degrees.formattedString), y: \(monitor.polarPoint.distance.formattedString))")
                    .fixedSize()
                Joystick(monitor: monitor, width: 250, shape: .circle)
            }
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
