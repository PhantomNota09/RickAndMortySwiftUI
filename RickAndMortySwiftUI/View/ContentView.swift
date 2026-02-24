//
//  ContentView.swift
//  RickAndMortySwiftUI
//
//  Created by Surya Rayala on 2/24/26.
//


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
    
    var body: some View {
        NavigationStack {
            VStack {
                // The list of characters
                if viewModel.isLoading {
                    // Show loading indicator
                    ProgressView("Searching...")
                        .padding()
                    Spacer()
                    
                } else if let errorMessage = viewModel.errorMessage {
                    // Show error message
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                    
                } else if viewModel.characters.isEmpty && !viewModel.searchText.isEmpty {
                    // No results found
                    Text("No characters found")
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                    
                } else {
                    // Show the list of characters
                    List(viewModel.characters) { character in
                        NavigationLink {
                            // We'll create this detail view next
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
                // Search after each keystroke
                Task {
                    await viewModel.searchCharacters()
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