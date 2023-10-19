//
//  ImageScreen.swift
//  SwiftUINavigationApp
//
//  Created by Enrico Sousa Gollner on 16/10/23.
//

import SwiftUI

struct ImageScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "trash")
                .resizable()  // We need to set it as resizable to apply a frame
//                .scaledToFill()
                .rotationEffect(.degrees(90))  // Rotation of the image
                .frame(width: 150, height: 150)
                .padding(50)
                .background(
                    Capsule().stroke(Color.pink, lineWidth: 5)
                )
                .shadow(radius: 5)
                .onTapGesture {
                    print("Clicked on the image")
                }
        }
    }
}

#Preview {
    ImageScreen()
}
