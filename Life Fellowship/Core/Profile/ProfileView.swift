//
//  ProfileView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/20/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Rectangle()
                        .fill(Color.teal.opacity(0.5))
                        .frame(maxHeight: 200)
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("IJ")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 100, maxHeight: 100)
                        .clipShape(Circle())
                        .padding(10)
                        .background(
                            Circle()
                                .strokeBorder(
                                    AngularGradient(gradient: Gradient(colors: [.purple, .blue, .teal, .mint, .teal, .blue, .purple]), center: .center),
                                    lineWidth: 5
                                )
                                .background(Color.white, in: Circle())
                                .shadow(radius: 8)
                        )
                        .padding(.top, -150)
                    
                    Text(currentUser?.fullname ?? "")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    VStack (spacing: 10) {
                        if let phone = currentUser?.phone {
                            HStack {
                                Text("Phone")
                                    .fontWeight(.light)
                                Spacer()
                                Text(phone)
                            }
                        }
                        HStack {
                            Text("Email")
                                .fontWeight(.light)
                            Spacer()
                            Text(verbatim: currentUser?.email ?? "")
                        }
                    }
                    .padding()
                    
                    
                        
                    if let bio = currentUser?.bio {
                        VStack (alignment: .leading){
                            HStack {
                                Text("Bio:")
                                    .font(.headline)
                                
                                Spacer()
                            }
                            
                            Text(bio)
                                .multilineTextAlignment(.leading)
                        }
                        .padding()
                    }
                    
                    if let favoriteVerse = currentUser?.favoriteVerse {
                        if let verseIdentifier = currentUser?.verseIdentifier {
                            VStack (alignment: .leading){
                                HStack {
                                    Text("Favorite Verse:")
                                        .font(.headline)
                                    
                                    Spacer()
                                }
                                
                                Text(verbatim: "\"For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life.\"")
                                    .multilineTextAlignment(.leading)
                                
                                HStack {
                                    Spacer()
                                    Text(" - John 3:16")
                                        .font(.headline)
                                }
                            }
                            .padding()
                        }
                    }
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        HStack {
                            Spacer()
                                Text("Sign Out")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                                    .padding()
                            Spacer()
                        }
                        .background(Color.red)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Edit")
                    }
                }
            }
            .foregroundColor(Color.black)
        }
    }
    
    @ViewBuilder
    func coverPhoto() -> some View {
        VStack {
            Rectangle()
                .fill(Color.teal.opacity(0.5))
                .frame(maxHeight: 200)
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ProfileView()
}
