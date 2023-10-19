//
//  DatePickerScreen.swift
//  SwiftUINavigationApp
//
//  Created by Enrico Sousa Gollner on 16/10/23.
//

import SwiftUI

struct DatePickerScreen: View {
    @State var selectedDate = Date()
    
    var body: some View {
        VStack(spacing: 30) {
            DatePicker("Pick a date", selection: $selectedDate, in: ...selectedDate /*Date until today*/ , displayedComponents: .date)
            
            DatePicker("Pick a hour", selection: $selectedDate, in: ...selectedDate, displayedComponents: .hourAndMinute)
            
            DatePicker("Pick both", selection: $selectedDate)  // Without a range, we can choose any date
                .datePickerStyle(.graphical)
            
            
            Text("The date picked is: \(formattedDate)")
        }
        .padding()
        
        var formattedDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            return dateFormatter.string(from: selectedDate)
        }
    }
}

#Preview {
    DatePickerScreen()
}
