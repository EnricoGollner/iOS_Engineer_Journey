//
//  ToggleScreen.swift
//  SwiftUINavigationApp
//
//  Created by Enrico Sousa Gollner on 16/10/23.
//

import SwiftUI

struct ToggleScreen: View {
    @State var isOn = false
    
    var body: some View {
        ZStack {
            Color(isOn ? .green : .red)
                .ignoresSafeArea()
            VStack {
                Toggle("Toggle being shown", isOn: $isOn)  // Do the update to isOn automaticaly
                    // .toggleStyle(.button) - It can also be button
                    .labelsHidden()  // Hide label
            }
            .padding()
        }
    }
}

#Preview {
    ToggleScreen()
}
