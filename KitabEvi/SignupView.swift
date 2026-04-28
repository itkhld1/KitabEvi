//
//  SignupView.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

internal import SwiftUI

struct SignupView: View {
    
    @ObservedObject var authViewModel: AuthenticationViewModel
    @State private var newUsername: String = ""
    @State private var selectedRole: UserRole = .customer
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .bold()
            
            TextField("Choose a Username", text: $newUsername)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
            
            Picker("Select Role", selection: $selectedRole) {
                Text("Customer").tag(UserRole.customer)
                Text("Admin").tag(UserRole.admin)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            Button {
                authViewModel.signup(username: newUsername, role: selectedRole)
            } label: {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}

//#Preview {
//    SignupView()
//}
