//
//  AuthenticationViewModel.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

import Foundation
internal import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var currentUser: User? = nil
    
    // logic func
    func login (username: String) {
        if username.lowercased() == "admin" {
            currentUser = User(username: username, role: .admin)
        } else {
            currentUser = User(username: username, role: .customer)
        }
    }
    
    func signup(username: String, role: UserRole) {
        currentUser = User(username: username, role: role)
    }
    
    func logout() {
        currentUser = nil
    }
}

