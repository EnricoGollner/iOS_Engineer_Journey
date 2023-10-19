//
//  ContentView.swift
//  SwiftUIBackFrontApp
//
//  Created by Enrico Sousa Gollner on 10/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var emailText: String = ""
    @State var passwordText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea(edges: .all)
                VStack(spacing: 15) {
                    Text("Login")
                        .foregroundStyle(.white)
                        .font(.system(size: 40, weight: .bold))
                    
                    Image("login")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding(.top, 20)
                    
                    Group {
                        TextField("E-mail", text: $emailText)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(.roundedBorder)
                            
                        SecureField("Password", text: $passwordText)
                            .textFieldStyle(.roundedBorder)
                    }
                    .foregroundStyle(.black)
                    
                    
                    
                    Button {
                        print("Clicked!")
                    } label: {
                        Text("Login")
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                            .background(Color(red: 228/255, green: 50/255, blue: 128/255))
                            .presentationCornerRadius(8)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    HStack() {
                        Text("Register here,")
                            .foregroundStyle(.white)
                        
                        Button {
                            print("Clicked!")
                        } label: {
                            Text("now!")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                            
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
            }
            
        }
        
    }
    
}

#Preview {
    ContentView()
}
