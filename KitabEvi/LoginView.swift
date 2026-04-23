//
//  LoginView.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var authViewModel: AuthenticationViewModel
    @State private var username: String = ""
    @State private var showingSignup = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Clean Bookstore")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Username (type 'admin' for Admin)", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                
                Button {
                    authViewModel.login(username: username)
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                NavigationLink(destination: SignupView(authViewModel: authViewModel)) {
                    Text("Don't have an account? Sign up")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
    }
}

//#Preview {
//    LoginView(authViewModel: )
//}
