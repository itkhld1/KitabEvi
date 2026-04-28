//
//  AdminDashboardView.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

internal import SwiftUI
import Charts

struct AdminDashboardView: View {
    
    @ObservedObject var authViewModel: AuthenticationViewModel
    @ObservedObject var inventoryVM: InventoryViewModel
    @ObservedObject var analyticsVM: AnalyticsViewModel
    
    @State private var showingAddBook = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Top: Editable Book List
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Inventory").font(.headline).padding(.horizontal)
                        
                        ForEach(inventoryVM.books) { book in
                            HStack(spacing: 15) {
                                NavigationLink(destination: EditBookView(inventoryVM: inventoryVM, bookID: book.id)) {
                                    HStack(spacing: 15) {
                                        if let data = book.imageData, let uiImage = UIImage(data: data) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 60)
                                                .cornerRadius(4)
                                        } else {
                                            Image(book.imageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 60)
                                                .cornerRadius(4)
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text(book.title).font(.body).foregroundColor(.primary)
                                            Text(book.author).font(.caption).foregroundColor(.secondary)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                Text(String(format: "$%.2f", book.price))
                                    .font(.body)
                                    .foregroundColor(.primary)
                                
                                Button(role: .destructive) {
                                    if let index = inventoryVM.books.firstIndex(where: { $0.id == book.id }) {
                                        inventoryVM.books.remove(at: index)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            
                            Divider()
                        }
                    }
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    Divider().padding(.horizontal)
                    
                    // Middle: Admin Sales Chart (Updated to match text requirement)
                    VStack(spacing: 15) {
                        Text("Monthly Sales Analytics").font(.headline)
                        Chart(analyticsVM.monthlySales) { stat in
                            BarMark(x: .value("Month", stat.month), y: .value("Sales", stat.amount))
                                .foregroundStyle(Color.orange.gradient)
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingAddBook = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") { authViewModel.logout() }
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView(inventoryVM: inventoryVM)
            }
        }
    }
}
