//
//  NetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Surya Rayala on 2/24/26.
//

import Foundation

// This class handles all API calls
class NetworkManager {
    
    // This function searches for characters by name
    func searchCharacters(name: String) async throws -> [Character] {
        
        // If the search is empty, return empty array
        guard !name.isEmpty else {
            return []
        }
        
        // Build the URL with the search name
        let urlString = "https://rickandmortyapi.com/api/character/?name=\(name)"
        
        // Make sure the URL is valid
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            throw URLError(.badURL)
        }
        
        // Fetch the data from the API
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the JSON into our CharacterResponse model
        let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
        
        // Return just the characters array
        return response.results
    }
}
