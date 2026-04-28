//
//  AddBookView.swift
//  KitabEvi
//
//  Created by itkhld on 27.04.2026.
//

import SwiftUI
import PhotosUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var inventoryVM: InventoryViewModel
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var price: Double = 0.0
    
    // Photo Picker State
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Cover")) {
                    HStack {
                        Spacer()
                        if let data = selectedImageData, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                        } else {
                            Image(systemName: "book.closed")
                                .font(.system(size: 80))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Label("Select from Photos", systemImage: "photo.on.rectangle")
                            .frame(maxWidth: .infinity)
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                await MainActor.run {
                                    selectedImageData = data
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    TextField("Price", value: $price, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                }
                
                Button("Add to Inventory") {
                    inventoryVM.addBook(
                        title: title,
                        author: author,
                        price: price,
                        imageName: "demo", // Default fallback name
                        imageData: selectedImageData
                    )
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .disabled(title.isEmpty || author.isEmpty)
                .foregroundColor(.blue)
            }
            .navigationTitle("New Book")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
