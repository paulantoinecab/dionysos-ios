//
//  LogOutIconButton.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 16/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct LogOutIconButton: View {
    var body: some View {
        Button(action: {}) {
            Image("LogOutIcon")
                .resizable()
                .frame(width: 30.0, height: 30.0)
                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 0.0, y: 5.0)

        }
    }
}

struct LogOutIconButton_Previews: PreviewProvider {
    static var previews: some View {
        LogOutIconButton()
    }
}
