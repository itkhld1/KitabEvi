//
//  EditBookView.swift
//  KitabEvi
//
//  Created by itkhld on 23.04.2026.
//

internal import SwiftUI
import PhotosUI

struct EditBookView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @ObservedObject var inventoryVM: InventoryViewModel
    let bookID: UUID
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var price: Double = 0.0
    @State private var imageName: String = ""
    
    // Photo Picker State
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    private func loadBook() {
        if let book = inventoryVM.books.first(where: { $0.id == bookID }) {
            title = book.title
            author = book.author
            price = book.price
            imageName = book.imageName
            selectedImageData = book.imageData
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Book Cover")) {
                HStack {
                    Spacer()
                    if let data = selectedImageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .cornerRadius(8)
                    } else {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .cornerRadius(8)
                    }
                    Spacer()
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Change Photo", systemImage: "photo.on.rectangle")
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
                
                TextField("Asset Name", text: $imageName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Section(header: Text("Book Details")) {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                TextField("Price", value: $price, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            
            Button("Save Changes") {
                inventoryVM.updateBook(
                    id: bookID,
                    newTitle: title,
                    newAuthor: author,
                    newPrice: price,
                    newImageName: imageName,
                    newImageData: selectedImageData
                )
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
