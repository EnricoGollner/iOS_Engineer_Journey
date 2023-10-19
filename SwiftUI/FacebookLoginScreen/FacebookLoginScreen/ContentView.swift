//
//  ContentView.swift
//  FacebookLoginScreen
//
//  Created by Enrico Sousa Gollner on 27/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack{
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 240)
                    
                    Spacer().frame(height: 64)
                    
                    VStack {
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                            .padding(.top, 24)
                            .padding(.bottom, 12)
                            .padding(.horizontal)
                        Divider()
                        SecureField("Password", text: $password)
                            
                            .padding(.top, 12)
                            .padding(.bottom, 24)
                            .padding(.horizontal)
                    }
                    .background(Color.white)
                    .cornerRadius(4.0)
                    
                    Spacer().frame(height: 16)
                    
                    Button(action: {
                        print("O email: \(email)\n foi inserido com a senha:\n \(password)")
                    }) {
                        Text("Login")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color("ButtonColor"))
                            .cornerRadius(4.0)
                    }
                    
                    Spacer()
                        .frame(height: 64)
                    
                    VStack(spacing: 8) {
                        Button(action: {}) {
                            Text("Don't have an account? Sign up.")
                                .foregroundColor(.white)
                                .bold()
                        }
                        
                        Button(action: {
                            
                        }) {
                            Text("Forgout your password?")
                                .foregroundColor(Color("TextColor"))
                        }
                    }
                        
                }
                .padding()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// #445790
