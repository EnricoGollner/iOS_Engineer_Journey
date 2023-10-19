//
//  ContentView.swift
//  SwiftUINavigationApp
//
//  Created by Enrico Sousa Gollner on 14/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var showSheet = false
    @State var showProgressViewSheet = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                Button("Go to sheet") {
                    showSheet.toggle()
                }
                    .sheet(isPresented: $showSheet , content: {
                        Screen2(type: ScreenType.Sheet)
                    })
                
                NavigationLink("Go to next Screen") {
                    Screen2(type: ScreenType.ScreenNavigate)
                }
                
                Button("Show progress view") {
                    showProgressViewSheet.toggle()
                }
                .sheet(isPresented: $showProgressViewSheet, content: {
                    ProgressScreen()
                })
            }
            .padding()
            .navigationTitle("Screen1")
        }
    }
}

#Preview {
    ContentView()
}
