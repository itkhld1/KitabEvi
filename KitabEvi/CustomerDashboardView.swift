//
//  CustomerDashboardView.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

import SwiftUI
import Charts

struct CustomerDashboardView: View {
    @ObservedObject var authViewModel: AuthenticationViewModel
    @ObservedObject var inventoryVM: InventoryViewModel
    @ObservedObject var analyticsVM: AnalyticsViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Top: Sales chart for customers
                    VStack(alignment: .center, spacing: 10) {
                        Text("Our Monthly Sales Impact").font(.headline)
                        Chart(analyticsVM.monthlySales) { stat in
                            BarMark(x: .value("Month", stat.month), y: .value("Sales", stat.amount))
                                .foregroundStyle(Color.blue.gradient)
                        }
                        .frame(height: 200)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Divider().padding(.horizontal)
                    
                    // Bottom: Read-only Book List
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Available Collection").font(.headline).padding(.horizontal)
                        
                        ForEach(inventoryVM.books) { book in
                            HStack {
                                Image(book.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 100)
                                    .cornerRadius(15)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(book.title).font(.headline)
                                    Text(book.author).font(.subheadline).foregroundColor(.secondary)
                                    Text(String(format: "$%.2f", book.price))
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Welcome, \(authViewModel.currentUser?.username ?? "Reader")")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        authViewModel.logout()
                    }
                }
            }
        }
    }
}
