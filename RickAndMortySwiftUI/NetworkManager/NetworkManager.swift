//
//  NetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Surya Rayala on 2/24/26.
//

import Foundation

// This class handles all API calls
class NetworkManager {
    
    // This function fetches characters from the API
    func fetchCharacters(name: String) async throws -> CharacterResponse {
        
        // Build the URL with the search name
        let urlString = Server.urlString.rawValue + "\(name)"
        
        // Print the URL to debug
        print("URL: \(urlString)")
        
        // Make sure the URL is valid
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            throw URLError(.badURL)
        }
        
        // Fetch the data from the API
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the JSON into our CharacterResponse model
        let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
        
        // Print how many results we got
        print("Found \(response.results.count) characters")
        
        // Return the full response
        return response
    }
}
