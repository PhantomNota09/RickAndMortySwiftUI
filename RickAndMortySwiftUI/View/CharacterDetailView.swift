//
//  CharacterDetailView.swift
//  RickAndMortySwiftUI
//
//  Created by Surya Rayala on 2/24/26.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Character Image (Full Width)
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                
                // Character Details
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Species
                    DetailRow(title: "Species", value: character.species)
                    
                    // Status
                    DetailRow(title: "Status", value: character.status)
                    
                    // Origin
                    DetailRow(title: "Origin", value: character.origin.name)
                    
                    // Type (only if available)
                    if !character.type.isEmpty {
                        DetailRow(title: "Type", value: character.type)
                    }
                    
                    // Created Date (formatted)
                    DetailRow(title: "Created", value: formattedDate(character.created))
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.large)
    }
    
    // Helper function to format the date
    private func formattedDate(_ dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        
        guard let date = isoFormatter.date(from: dateString) else {
            return dateString
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
}

// MARK: - Detail Row
struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .textCase(.uppercase)
            
            Text(value)
                .font(.body)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CharacterDetailView(character: Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: Origin(name: "Earth (C-137)", url: ""),
            location: Location(name: "Citadel of Ricks", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [],
            url: "",
            created: "2017-11-04T18:48:46.250Z"
        ))
    }
}