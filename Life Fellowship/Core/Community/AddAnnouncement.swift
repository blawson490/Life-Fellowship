//
//  AddAnnouncement.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/24/24.
//

import SwiftUI

struct AddAnnouncement: View {
    @ObservedObject private var viewModel = AddAnnouncementViewModel()
    @State private var showImagePicker = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Preview")) {
                        if let imageData = viewModel.announcementImageData {
                            announcementPreview(imageData: imageData, title: viewModel.title, shortDescription: viewModel.shortDescription)
                                .aspectRatio(16 / 9, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        } else {
                            Button {
                                showImagePicker = true
                            } label: {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("Tap to add an image")
                                        Spacer()
                                    }
                                }
                                .foregroundColor(Color(uiColor: .label))
                                .frame(height: 200)
                                .background {
                                    Rectangle()
                                        .fill(Color(uiColor: .tertiarySystemGroupedBackground))
                                }
                                .aspectRatio(16 / 9, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                    }
                    
                    Section(header: Text("Preview Details")) {
                        TextField("Enter a title", text: $viewModel.title)
                        
                        TextField("Enter a short description", text: $viewModel.shortDescription)
                        
                        ZStack (alignment: .top) {
                            TextEditor(text: $viewModel.longDescription)
                                .frame(maxWidth: .infinity, minHeight: 25, maxHeight: 300)
                                .padding(.horizontal, -3)
                            
                            Text(viewModel.longDescription != "" ? "" : "Enter a long description")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 7)
                                .foregroundStyle(Color(uiColor: .tertiaryLabel))
                        }
                    }
                }
                Button("Create Announcement") {
                    closeKeyboard()
                    viewModel.createAnnouncement()
                    dismiss()
                    // Dismiss after uploaded using a callback and adding the new announcement to the list of announcements
                }
                .font(.headline)
                .alert(viewModel.errorTitle, isPresented: $viewModel.showError) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(viewModel.errorDescription)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: viewModel.imagePickerSourceType, selectedImage: $viewModel.announcementImageData)
            }
            .navigationTitle("Create New Announcement")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
        .overlay {
            if viewModel.isLoading {
                VStack {
                    HStack {
                        Spacer()
                        LoadingView()
                        Spacer()
                    }
                }
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    @ViewBuilder
    func announcementPreview(imageData: Data, title: String, shortDescription: String) -> some View {
        var gradient: LinearGradient {
            .linearGradient(
                Gradient(colors: [.black.opacity(0.8), .black.opacity(0)]),
                            startPoint: .bottom,
                            endPoint: .top)
        }
            GeometryReader {
                let size = $0.size
                if let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(16 / 9, contentMode: .fit)
                        .overlay{
                            ZStack(alignment: .bottomLeading) {
                                gradient
                                VStack(alignment: .leading) {
                                    Text(title)
                                        .font(.title)
                                        .bold()
                                    Text(shortDescription)
                                }
                                .padding()
                            }
                            .foregroundColor(.white)
                        }
                }
            }
    }
}

#Preview {
    AddAnnouncement()
}
