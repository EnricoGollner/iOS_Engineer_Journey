//
//  ChangeValue.swift
//  PropertyWrappersApp
//
//  Created by Enrico Sousa Gollner on 14/10/23.
//

import SwiftUI

struct ChangeValue: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var value: CGFloat = 50.0
    
    var body: some View {
        ZStack {
            Color(.cyan)
            VStack {
                SetValue(value: $value)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                
                
                Slider(value: $value, in: 0...100, step: 1.1)
                    .padding()
                
                Button("Return") {
                    dismiss()
                }
            }
        }
        .ignoresSafeArea()
        
    }
}

struct SetValue: View {
    @Binding var value: CGFloat;
    
    var body: some View {
        Text(numFraction2(value: value) ?? "Erro ao converter")
    }
    
    func numFraction2(value: CGFloat) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: value))
    }
}

#Preview {
    ChangeValue()
}
