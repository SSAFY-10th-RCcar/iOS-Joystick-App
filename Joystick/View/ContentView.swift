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
    @State private var showAdressInputAlert = false
    @State private var showTopicInputAlert = false
    @State private var brokerAddress = ""
    @State private var topic = ""
    @StateObject private var locationPermission: LocationPermission = LocationPermission()
    @StateObject private var mqttManager: MQTTManager = MQTTManager.shared()

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
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Text("XY Point = (x: \(monitor.xyPoint.x.formattedString), y: \(monitor.xyPoint.y.formattedString))")
                    .fixedSize()
                Text("Polar Point = (radians: \(monitor.polarPoint.degrees.formattedString), y: \(monitor.polarPoint.distance.formattedString))")
                    .fixedSize()
                Joystick(monitor: monitor, width: 250, shape: .circle)
                    .onChange(of: monitor.xyPoint.x) {
                        send(message: String(describing: monitor.xyPoint.x) + " " + String(describing: monitor.xyPoint.y))
                    }
                Spacer()
                Button {
                    if (!mqttManager.isConnected()) {
                        showAdressInputAlert.toggle()
                    } else if (!mqttManager.isSubscribed()) {
                        showTopicInputAlert.toggle()
                    }
                    else {
                        disconnect()
                    }
                } label : {
                    ConnectionStatusBar(message: mqttManager.connectionStateMessage(), isConnected: mqttManager.isConnected())
                        .opacity(0.9)
                }
                .alert("Enter broker Address", isPresented: $showAdressInputAlert) {
                    TextField("brokerAddress", text: $brokerAddress)
                    Button("OK", action: configureAndConnect)
                    Button("Cancel", role: .cancel) {}
                }
                .alert("Enter Topic", isPresented: $showTopicInputAlert) {
                    TextField("Topic", text: $topic)
                    Button("OK", action: subscribe)
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
        .onAppear() {
            locationPermission.requestLocationPermission()
        }
    }

    private func configureAndConnect() {
        mqttManager.initializeMQTT(host: brokerAddress, identifier: UUID().uuidString)
        mqttManager.connect()
    }

    private func disconnect() {
        mqttManager.disconnect()
    }

    private func subscribe() {
        mqttManager.subscribe(topic: topic)
    }

    private func send(message: String) {
        mqttManager.publish(with: message)
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
