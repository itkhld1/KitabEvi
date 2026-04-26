//
//  InventoryViewModel.swift
//  KitabEvi
//
//  Created by itkhld on 22.04.2026.
//

import Foundation
internal import Combine

class InventoryViewModel: ObservableObject {
    // @Published means whenever this array changes, the UI automatically updates
    @Published var books: [Book] = []
    
    // Golden Data
    private let goldenData: [Book] = [
        Book(title: "Saatleri Ayarlama Enstitüsü", author: "Ahmet Hamdi Tanpınar", price: 185.00, imageName: "Saatleri Ayarlama Enstitüsü"),
        Book(title: "My Name is Red", author: "Orhan Pamuk", price: 210.00, imageName: "My Name is Red"),
        Book(title: "White Castle", author: "Orhan Pamuk", price: 195.50, imageName: "the white castle")
    ]
    
    
    // Junk Data
    private let junkData: [Book] = [
        Book(title: "book 1", author: "me", price: 0.00, imageName: "random"),
        Book(title: "asdfasdf", author: "test author", price: 999999.00, imageName: "random"),
        Book(title: "test_book_final", author: "qwerty", price: 1.00, imageName: "random")
    ]
    
    init() {
        self.books = junkData
    }
    
    // Instantly restores the perfect, sales-ready data
        func resetToGoldenState() {
            self.books = goldenData
        }
    
    func addRandomJunk() {
            let randomTitles = ["qweqwe", "test_123", "do_not_delete", "null", "undefined"]
            let randomPrice = Double.random(in: 0...10000)
            
            let newJunkBook = Book(
                title: randomTitles.randomElement() ?? "error",
                author: "unknown",
                price: randomPrice,
                imageName: "random"
            )
            self.books.append(newJunkBook)
        }
    
    // Allows the Admin to save edits made to a specific book
    func updateBook(id: UUID, newTitle: String, newAuthor: String, newPrice: Double, newImageName: String) {
        if let index = books.firstIndex(where: { $0.id == id }) {
            books[index].title = newTitle
            books[index].author = newAuthor
            books[index].price = newPrice
            books[index].imageName = newImageName
        }
    }
}
