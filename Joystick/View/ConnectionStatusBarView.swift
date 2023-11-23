//
//  ConnectionStatusBarView.swift
//  Joystick
//
//  Created by 김민재 on 11/23/23.
//

import SwiftUI

struct ConnectionStatusBar: View {
    var message: String
    var isConnected: Bool
    var body: some View {
        HStack {
            Text(message)
                .font(.footnote)
                .foregroundColor(.white)
                .padding()
        }.frame(maxWidth: .infinity)
        .background(isConnected ? Color.green : Color.red)

    }
}

struct ConnectionStatusBar_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionStatusBar(message: "Hello", isConnected: true)
    }
}
