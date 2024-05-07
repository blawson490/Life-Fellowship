//
//  DevotionalView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/5/24.
//

import SwiftUI
import WebKit

struct DevotionalView: View {
    @State private var devotional: Devotional?
    @State private var isLoading = true
    @State private var errorText = ""

    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            if isLoading {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView("Loading...")
                        Spacer()
                    }
                    Spacer()
                }
            } else if let devotional = devotional {
                if !devotional.hidden {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            Text(devotional.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            // Scripture styled as a quote
                            HStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .frame(width: 4)
                                    .padding(.leading, 8)
                                    .opacity(0.75)
                                
                                VStack {
                                    Text(devotional.verse)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .italic()
                                        .padding(.leading, 5)
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Text(devotional.scripture)
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                            .italic()
                                            .padding(.horizontal, 5)
                                    }
                                    
                                }
                                .frame(alignment: .trailing)
                                .padding(.horizontal, 8)
                            }
                            .padding(.vertical, 4)
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Insight")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(devotional.insight)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Action")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(devotional.action)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 5)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Reflection")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(devotional.reflection)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 5)
                            }
                            
                            
                            Button(action: {
                                dismiss()
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text("Finished Reading")
                                        .foregroundStyle(Color.white)
                                        .bold()
                                    Spacer()
                                }
                                .padding()
                                .background(Color.accentColor)
                                .cornerRadius(8)
                                .padding()
                            })
                            .padding(.vertical)
                            
                        }
                        .padding(.top, 75)
                        .padding(.horizontal)
                        
                    }
                } else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("There is no devotional for today.")
                            Spacer()
                        }
                        Spacer()
                    }
                }
            } else {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(errorText)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .overlay {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .font(.callout)
                            .foregroundStyle(Color(uiColor: .label))
                            .padding(12)
                            .background(
                                Circle()
                                    .fill(Color("AppBackground"))
                            )
                            .padding(.horizontal)
                    })
                    Spacer()
                    if let currentUser = viewModel.currentUser {
                        if let devotional {
                            if !devotional.hidden {
                                HStack(spacing: 4) {
                                    Menu(content: {
                                        Button(action: {
                                            print("DEBUG: Love Devotional")
                                        }, label: {
                                            Label("Love", systemImage: "heart")
                                        })
                                        Button(role: .destructive, action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                            Label("Report", systemImage: "flag")
                                        })
                                        if currentUser.role == "admin" || currentUser.role == "global" {
                                            Button(role: .destructive, action: {
                                                print("DEBUG: Report Devotional")
                                            }, label: {
                                                Label("Hide Devotional", systemImage: "eye.slash.fill")
                                            })
                                        }
                                    }, label: {
                                        Image(systemName: "ellipsis")
                                            .foregroundStyle(Color(uiColor: .label))
                                            .padding(16)
                                            .background(
                                                Circle()
                                                    .fill(Color("AppBackground"))
                                            )
                                            .padding(.leading)
                                    })
                                }
                            } else if currentUser.role == "admin" || currentUser.role == "global" {
                                HStack(spacing: 4) {
                                    Menu(content: {
                                        Button(action: {
                                            print("DEBUG: View Devotional")
                                        }, label: {
                                            Label("View Devotional", systemImage: "archivebox")
                                        })
                                        Button(role: .destructive, action: {
                                            print("DEBUG: Show Devotional")
                                        }, label: {
                                            Label("Show Devotional", systemImage: "eye.fill")
                                        })
                                    }, label: {
                                        Image(systemName: "ellipsis")
                                            .foregroundStyle(Color(uiColor: .label))
                                            .padding(16)
                                            .background(
                                                Circle()
                                                    .fill(Color("AppBackground"))
                                            )
                                            .padding(.leading)
                                    })
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 8)
                .background(Color(uiColor: .systemBackground))
                .overlay {
                    if let devotional {
                        HStack {
                            Spacer()
                            if let currentUser = viewModel.currentUser {
                                if currentUser.role == "admin" || currentUser.role == "global" {
                                    if devotional.hidden {
                                        Text("Devotional Hidden")
                                            .padding(.bottom, 8)
                                            .font(.callout)
                                    } else {
                                        Text(devotional.title)
                                            .padding(.bottom, 8)
                                            .font(.callout)
                                    }
                                } else {
                                    if !devotional.hidden {
                                        Text(devotional.title)
                                            .padding(.bottom, 8)
                                            .font(.callout)
                                    }
                                }
                            } else {
                                if !devotional.hidden {
                                    Text(devotional.title)
                                        .padding(.bottom, 8)
                                        .font(.callout)
                                }
                            }
                            Spacer()
                        }
                    } else {
                        HStack {
                            Spacer()
                            Text("No Devotional")
                                .padding(.bottom, 8)
                                .font(.callout)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            fetchTodaysDevotional()
        }
    }

    private func fetchTodaysDevotional() {
        guard let url = URL(string: "https://lifefellowship.lawsonserver.xyz/api/devotionals/today") else {
            self.errorText = "Invalid URL"
            self.isLoading = false
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorText = "Error fetching devotional: \(error.localizedDescription)"
                    self.isLoading = false
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.errorText = "Error fetching devotional: Server error"
                    self.isLoading = false
                }
                return
            }

            if let data = data {
                do {
                    let decodedDevotional = try JSONDecoder().decode(Devotional.self, from: data)
                    DispatchQueue.main.async {
                        self.devotional = decodedDevotional
                        self.isLoading = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorText = "Error decoding data: \(error.localizedDescription)"
                        self.isLoading = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorText = "No data received"
                    self.isLoading = false
                }
            }
        }
        task.resume()
    }
    
    private func hideDevotional() {
        
    }
}

#Preview {
    DevotionalView()
        .environmentObject(AuthViewModel())
}
