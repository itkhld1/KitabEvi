//
//  AdminDashboardView.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

import SwiftUI
import Charts

struct AdminDashboardView: View {
    
    @ObservedObject var authViewModel: AuthenticationViewModel
    @ObservedObject var inventoryVM: InventoryViewModel
    @ObservedObject var analyticsVM: AnalyticsViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Top: Editable Book List
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Inventory").font(.headline).padding(.horizontal)
                        
                        ForEach(inventoryVM.books) { book in
                            NavigationLink(destination: EditBookView(inventoryVM: inventoryVM, bookID: book.id)) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(book.title).font(.body).foregroundColor(.primary)
                                        Text(book.author).font(.caption).foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Text(String(format: "$%.2f", book.price))
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color(UIColor.systemBackground))
                            }
                            Divider()
                        }
                    }
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    Divider().padding(.horizontal)
                    
                    // Middle: Admin Revenue Chart
                    VStack(spacing: 15) {
                        Text("Monthly Revenue (Admin Only)").font(.headline)
                        Chart(analyticsVM.monthlyRevenue) { stat in
                            LineMark(x: .value("Month", stat.month), y: .value("Revenue", stat.amount))
                                .interpolationMethod(.catmullRom)
                        }
                        .frame(height: 200)
                    }
                    .padding(.horizontal)
                    
                    Divider().padding(.horizontal)
                    
                    // Bottom: Admin Controls
                    HStack {
                        Button {
                            withAnimation { 
                                inventoryVM.addRandomJunk()
                                analyticsVM.generateJunkData()
                            }
                        } label: {
                            Text("Stress Test")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            withAnimation(.spring()) { 
                                inventoryVM.resetToGoldenState() 
                                analyticsVM.resetToGoldenState()
                            }
                        } label: {
                            Text("Admin Reset")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                .padding(.vertical)
            }
            .navigationTitle("Admin Panel")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") { authViewModel.logout() }
                }
            }
        }
    }
}
