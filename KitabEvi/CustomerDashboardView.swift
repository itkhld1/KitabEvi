//
//  CustomerDashboardView.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

internal import SwiftUI
import Charts

struct CustomerDashboardView: View {
    @ObservedObject var authViewModel: AuthenticationViewModel
    @ObservedObject var inventoryVM: InventoryViewModel
    @ObservedObject var analyticsVM: AnalyticsViewModel
    
    // Cart state
    @State private var cart: [Book] = []
    @State private var showingCheckoutAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Top: Sales chart for customers
                    VStack(alignment: .center, spacing: 10) {
                        Text("Market Insights").font(.headline)
                        Chart(analyticsVM.monthlySales) { stat in
                            BarMark(x: .value("Month", stat.month), y: .value("Sales", stat.amount))
                                .foregroundStyle(Color.blue.gradient)
                        }
                        .frame(height: 180)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    if !cart.isEmpty {
                        VStack {
                            HStack {
                                Text("Items in Cart: \(cart.count)").bold()
                                Spacer()
                                Button("Checkout") {
                                    showingCheckoutAlert = true
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    
                    Divider().padding(.horizontal)
                    
                    // Bottom: Book List with Add to Cart
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Browse Books").font(.headline).padding(.horizontal)
                        
                        ForEach(inventoryVM.books) { book in
                            HStack(spacing: 15) {
                                // Image Display
                                if let data = book.imageData, let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 90)
                                        .cornerRadius(8)
                                } else {
                                    Image(book.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 90)
                                        .cornerRadius(8)
                                }
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(book.title).font(.body).bold()
                                    Text(book.author).font(.caption).foregroundColor(.secondary)
                                    Text(String(format: "$%.2f", book.price))
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                }
                                
                                Spacer()
                                
                                Button {
                                    withAnimation {
                                        cart.append(book)
                                    }
                                } label: {
                                    Image(systemName: "cart.badge.plus")
                                        .font(.title3)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Shop")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        authViewModel.logout()
                    }
                }
            }
            .alert("Order Confirmed!", isPresented: $showingCheckoutAlert) {
                Button("OK") {
                    cart.removeAll()
                }
            } message: {
                Text("Your items have been processed successfully. Thank you for shopping at Clean Bookstore!")
            }
        }
    }
}
