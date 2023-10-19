//
//  StepperScreen.swift
//  SwiftUINavigationApp
//
//  Created by Enrico Sousa Gollner on 16/10/23.
//

import SwiftUI

struct StepperScreen: View {
    @State var stepperValue: Int = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Stepper("Stepper created: \(stepperValue)", value: $stepperValue, in: 0...10, step: 2)
//                .labelsHidden()
                
        }
        .padding()
    }
}

#Preview {
    StepperScreen()
}
