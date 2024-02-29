//
//  CommunityViewModel.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/24/24.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore

class CommunityViewModel: ObservableObject {
    @Published var CurrentUser: User?
    @Published var announcements: [Announcement]
    private var cancellables = Set<AnyCancellable>()
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorTitle = ""
    @Published var errorDescription = ""
    
    init() {
        announcements = []
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.CurrentUser = user
//            print(self?.CurrentUser ?? "")
        }.store(in: &cancellables)
    }
    
    func getAnnouncements() {
        // Check cache
        
        // if cache is 1hr old fetch new announcements from firebase
        
        // cache announcements
        
//        print("DEBUG: fetching announcements")
        fetchAnnouncements(completion: { fetchedAnnouncements in
            self.announcements = fetchedAnnouncements
        })
    }
    
    func fetchAnnouncements(completion: @escaping ([Announcement]) -> Void) {
        self.isLoading = true
        let db = Firestore.firestore()
        
        db.collection("announcements")
            .order(by: "createdTimestamp", descending: true)
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting top saved recipes: \(err)")
                } else {
                    let announcements = querySnapshot?.documents.compactMap { try? $0.data(as: Announcement.self) }
                    self.errorTitle = "Success"
                    self.errorDescription = "Announcements were downloaded successfully"
                    self.isLoading = false
                    self.showError = true
//                    print("DEBUG: Announcements: \(announcements ?? [])")
                    completion(announcements ?? [])
                }
            }
    }
}
