//
//  CharacterViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Surya Rayala on 2/24/26.
//

import Foundation

@Observable
class CharacterViewModel {
    
    var characters: [Character] = []
    var searchText: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    
    // Create an instance of NetworkManager
    private let networkManager = NetworkManager()
    
    // This function handles the search logic
    func searchCharacters() async {
        // Don't search if text is empty
        guard !searchText.isEmpty else {
            characters = []
            return
        }
        
        // Show loading indicator
        isLoading = true
        errorMessage = nil
        
        do {
            // Convert search text to lowercase before calling API
            let lowercasedSearch = searchText.lowercased()
            
            // Call NetworkManager to fetch data
            let response = try await networkManager.fetchCharacters(name: lowercasedSearch)
            
            // Extract characters from response
            characters = response.results
            
        } catch {
            print("Error: \(error)")
        }
        
        // Hides loading indicator
        isLoading = false
    }
}
