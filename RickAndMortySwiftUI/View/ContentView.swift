//
//  ContentView.swift
//  RickAndMortySwiftUI
//
//  Created by Surya Rayala on 2/24/26.
//

import SwiftUI

struct ContentView: View {
    
    // Create the ViewModel
    @State private var viewModel = CharacterViewModel()
    @State private var hasLoadedInitialData = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // The list of characters
                if viewModel.isLoading {
                    // Show loading indicator with "Please wait" message
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Please wait")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // Show the list of characters
                    List(viewModel.characters) { character in
                        NavigationLink {
                            CharacterDetailView(character: character)
                        } label: {
                            CharacterRow(character: character)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Rick and Morty")
            .searchable(text: $viewModel.searchText, prompt: "Search characters...")
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                // Trigger search when text changes
                Task {
                    await viewModel.searchCharacters()
                }
            }
            .alert("Error", isPresented: $viewModel.hasError) {
                Button("OK") {
                    viewModel.clearError()
                }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
            .onAppear {
                // Only load default data on first launch
                if !hasLoadedInitialData {
                    hasLoadedInitialData = true
                    viewModel.searchText = "rick"
                    Task {
                        await viewModel.searchCharacters()
                    }
                }
            }
        }
    }
}

// MARK: - Character Row
struct CharacterRow: View {
    let character: Character
    
    var body: some View {
        HStack(spacing: 12) {
            // Character image
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Character info
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.headline)
                
                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
