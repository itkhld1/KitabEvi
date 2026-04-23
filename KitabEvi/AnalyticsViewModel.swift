//
//  AnalyticsViewModel.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

import Foundation
internal import Combine

class AnalyticsViewModel: ObservableObject {
    @Published var monthlySales: [Stat] = []
    @Published var monthlyRevenue: [Stat] = []
    
    private let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    init() {
        // Start with junk data to demonstrate the "cleanup" later
        generateJunkData()
    }
    
    func resetToGoldenState() {
        // Perfectly trending growth data
        monthlySales = months.enumerated().map { index, month in
            Stat(month: month, amount: Double(100 + (index * 15) + Int.random(in: 0...10)))
        }
        
        monthlyRevenue = months.enumerated().map { index, month in
            Stat(month: month, amount: Double(1000 + (index * 200) + Int.random(in: 0...100)))
        }
    }
    
    func generateJunkData() {
        // Erratic, broken-looking data
        monthlySales = months.map { month in
            Stat(month: month, amount: Double.random(in: 0...300))
        }
        
        monthlyRevenue = months.map { month in
            // Some months have 0 revenue, some have huge spikes
            let amount = Double.random(in: 0...1) > 0.3 ? Double.random(in: 500...5000) : 0
            return Stat(month: month, amount: amount)
        }
    }
}
