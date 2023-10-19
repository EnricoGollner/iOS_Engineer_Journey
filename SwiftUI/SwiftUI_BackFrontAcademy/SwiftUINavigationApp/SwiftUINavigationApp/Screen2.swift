//
//  ScreenDestiny.swift
//  SwiftUINavigationApp
//
//  Created by Enrico Sousa Gollner on 14/10/23.
//

import SwiftUI

enum ScreenType {
    case Sheet
    case ScreenNavigate
}

struct Screen2: View {
    @Environment(\.dismiss) var dismiss
    @State var type: ScreenType;
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            Text("I'm screen 2")
            
            Text("I'm a \(type == ScreenType.Sheet ? "Sheet" : "Full Screen")")
            
            Button("Return") {
                dismiss()
            }
        }
        
    }
}

#Preview {
    Screen2(type: ScreenType.Sheet)
}
