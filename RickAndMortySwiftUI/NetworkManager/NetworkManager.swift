//
//  NetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Surya Rayala on 2/24/26.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchCharacters(name: String) async -> APIError
}

// This class handles all API calls
class NetworkManager {
    
    // This function fetches characters from the API
    func fetchCharacters(name: String) async -> APIError {
        
        // Build the URL with the search name
        let urlString = Server.urlString.rawValue + "\(name)"
        
        print("URL: \(urlString)")
        
        // Making sure the URL is valid
        guard let url = URL(string: urlString) else {
            return .invalidURL
        }
        
        do {
            // Fetch the data from the API
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode the JSON into our CharacterResponse model
            let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
            
            // Return the full response
            return .success(response.results)
        }
        catch {
            return .failed
        }
    }
}
