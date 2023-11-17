// An example Joystick
// Copy this example and modify it

import SwiftUI
import SwiftUIJoystick

public struct Joystick: View {

    /// The monitor object to observe the user input on the Joystick in XY or Polar coordinates
    @ObservedObject public var joystickMonitor: JoystickMonitor
    /// The width or diameter in which the Joystick will report values
    ///  For example: 100 will provide 0-100, with (50,50) being the origin
    private let dragDiameter: CGFloat
    /// Can be `.rect` or `.circle`
    /// Rect will allow the user to access the four corners
    /// Circle will limit Joystick it's radius determined by `dragDiameter / 2`
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
