// An example Joystick
// Copy this example and modify it

import SwiftUI
import SwiftUIJoystick

public struct Joystick: View {

    @ObservedObject public var joystickMonitor: JoystickMonitor
    private let dragDiameter: CGFloat
    private let shape: JoystickShape

    public init(monitor: JoystickMonitor, width: CGFloat, shape: JoystickShape = .rect) {
        self.joystickMonitor = monitor
        self.dragDiameter = width
        self.shape = shape
    }

    public var body: some View {
        JoystickBuilder(
            monitor: self.joystickMonitor,
            width: self.dragDiameter,
            shape: self.shape,
            background: {
                ZStack {
                    Circle()
                        .fill(Color.cchGreen)
                        .overlay(
                            Circle()
                                .stroke(Color.clear)
                                .shadow(color: Color.white, radius: 5)
                        )
                        .opacity(0.6)
                }
            },
            foreground: {
                Circle()
                    .fill(RadialGradient(colors: [.white, .jBrown], center: .center, startRadius: 1, endRadius: 30))
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .shadow(color: Color.white, radius: 5)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 8)
                            .offset(x: -2, y: -2)
                            .shadow(color: Color.white, radius: 5)
                            .blur(radius: 1)
                    )
            },
            locksInPlace: false
        )
    }
}


#Preview {
    ContentView()
}
