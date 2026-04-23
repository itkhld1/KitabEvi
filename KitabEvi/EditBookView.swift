//
//  EditBookView.swift
//  KitabEvi
//
//  Created by itkhld on 23.04.2026.
//

import SwiftUI

struct EditBookView: View {
    
    // environment allows to dismiss the screen after saving
    @Environment (\.dismiss) var dismiss
    
    @ObservedObject var inventoryVM: InventoryViewModel
    let bookID: UUID
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var price: Double = 0.0
    
    private func loadBook() {
        if let book = inventoryVM.books.first(where: { $0.id == bookID }) {
            title = book.title
            author = book.author
            price = book.price
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Book Details")) {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                
                // number formatter for price
                TextField("Price", value: $price, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            
            Button("Save Changes") {
                inventoryVM.updateBook(id: bookID, newTitle: title, newAuthor: author, newPrice: price)
                dismiss()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.blue)
        }
        .navigationTitle("Edit Book")
        .onAppear {
            loadBook()
        }
    }
}

//#Preview {
//    EditBookView()
//}
