//
//  RootView.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var authViewModel = AuthenticationViewModel()
    @StateObject private var inventoryVM = InventoryViewModel()
    @StateObject private var analyticsVM = AnalyticsViewModel()
    
    var body: some View {
        if let user = authViewModel.currentUser {
            if user.role == .admin {
                AdminDashboardView(authViewModel: authViewModel, inventoryVM: inventoryVM, analyticsVM: analyticsVM)
            } else {
                CustomerDashboardView(authViewModel: authViewModel, inventoryVM: inventoryVM, analyticsVM: analyticsVM)
            }
        } else {
            // Login view when no user is authenticated
            LoginView(authViewModel: authViewModel)
        }
    }
}
