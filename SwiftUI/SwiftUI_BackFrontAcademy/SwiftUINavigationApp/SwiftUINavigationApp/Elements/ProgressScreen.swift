//
//  ProgressScreen.swift
//  SwiftUINavigationApp
//
//  Created by Enrico Sousa Gollner on 16/10/23.
//

import SwiftUI

struct ProgressScreen: View {
    
    @State var progress: Double = 0
    var maxValue: Double = 10
    
    var body: some View {
        VStack(spacing: 10) {
            Button("Up") {
                progress += 0.5
            }
            
            ProgressView(value: progress, total: maxValue)
                .padding()
            
            Button("Start") {
                startProgress()
            }
        }
        .padding()
    }
    
    func startProgress() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.progress < maxValue {
                progress += 2
            } else {
                timer.invalidate()
                progress = 0
            }
        }
    }
}

#Preview {
    ProgressView()
}
