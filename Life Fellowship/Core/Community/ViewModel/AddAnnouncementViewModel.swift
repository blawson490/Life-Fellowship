//
//  AddAnnouncementViewModel.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/24/24.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore
import FirebaseStorage

class AddAnnouncementViewModel: ObservableObject {
    @Published var title = ""
    @Published var shortDescription = ""
    @Published var longDescription = ""
    @Published var privacy = "public"
    @Published var isHidden = false
    @Published var isLoading = false
    
    @Published var showError = false
    @Published var errorTitle = ""
    @Published var errorDescription = ""
    
    //User
    @Published var userSession: FirebaseAuth.User?
    @Published var CurrentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
    
    // Image
    @Published var announcementImageData: Data? = nil
    @Published var showImagePicker: Bool = false
    var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
//    func generatePreview() -> Announcement {
//        Anno
//    }
    
    func createAnnouncement() {
        isLoading = true
        
        if announcementImageData == nil {
            errorTitle = "Image Required"
            errorDescription = "You must add an image to create an announcement."
            isLoading = false
            showError = true
            return
        }
        if title == "" {
            errorTitle = "Title Required"
            errorDescription = "You must add a title to create an announcement."
            isLoading = false
            showError = true
            return
        }
        if shortDescription == "" {
            errorTitle = "Short Description Required"
            errorDescription = "You must add a short description to create an announcement."
            isLoading = false
            showError = true
            return
        }
        // Create a Task to upload or update recipe and handle errors
        Task {
            do {
                if let userUID = userSession?.uid {
                    
                    if let imageData = announcementImageData {
                    // Create the announcement object
                    let newAnnouncement = Announcement(title: title, shortDescription: shortDescription, longDescription: longDescription, privacy: privacy, createdBy: userUID)
                    
                    let documentReference = try await createDocumentAtFirebase(newAnnouncement)
                    let announcementID = documentReference.documentID
                    
                        // Upload image and update announcement
                        let storageRef = Storage.storage().reference().child("announcements").child(announcementID).child("image.jpg")
                        
                        let _ = try await storageRef.putDataAsync(imageData)
                        let downloadURL = try await storageRef.downloadURL()
                        
                        let updatedAnnouncement =  Announcement(id: announcementID, title: newAnnouncement.title, image: downloadURL, shortDescription: newAnnouncement.shortDescription, longDescription: newAnnouncement.longDescription, privacy: newAnnouncement.privacy, createdTimestamp: newAnnouncement.createdTimestamp, createdBy: newAnnouncement.createdBy)
                        try await updateDocumentAtFirebase(updatedAnnouncement, documentReference)
                        
                        //                        onCreate(updatedRecipe)
                        errorTitle = "Success"
                        errorDescription = "Announcement was uploaded successfully"
                        isLoading = false
                        showError = true
                    }
                }
            } catch {
                errorTitle = "There was an error"
                errorDescription = error.localizedDescription
                isLoading = false
                showError = true
            }
        }
    }
    
    func createDocumentAtFirebase(_ announcement: Announcement) async throws -> DocumentReference {
        // Create new document reference
        let newAnnouncementRef = Firestore.firestore().collection("announcements").document()

        // Encode the recipe into [String: Any]
        let announcementData = try Firestore.Encoder().encode(announcement)

        let firestore = Firestore.firestore()
        
        do {
            _ = try await firestore.runTransaction { transaction, _ in
                // Save the announcement to the new document
                transaction.setData(announcementData, forDocument: newAnnouncementRef)
                // Return nil because we don't need to use the return value
                return nil
            }
            return newAnnouncementRef
        } catch {
            print("Transaction failed: \(error)")
            throw error
        }
    }

    
    func updateDocumentAtFirebase(_ announcement: Announcement, _ documentReference: DocumentReference) async throws {
        try documentReference.setData(from: announcement)
    }
}
