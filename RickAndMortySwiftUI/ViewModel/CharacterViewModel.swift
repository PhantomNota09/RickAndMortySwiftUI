//
//  CharacterViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Surya Rayala on 2/24/26.
//

import Foundation

protocol CharacterViewModelProtocol: AnyObject {
    
    func searchCharacters() async
}

@Observable
class CharacterViewModel: CharacterViewModelProtocol {
    
    var characters: [Character] = []
    var searchText: String = ""
    var isLoading: Bool = false
    var hasError: Bool = false
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
        
        // Start loading
        isLoading = true
        clearError()
        
        // Convert search text to lowercase before calling API
        let lowercasedSearch = searchText.lowercased()
        
        // Call NetworkManager to fetch data
        let response = await networkManager.fetchCharacters(name: lowercasedSearch)
        
        // Stop loading
        isLoading = false
        
        // Handle the different APIError cases
        switch response {
        case .success(let characterList):
            characters = characterList
        case .invalidURL, .empty, .failed:
            characters = []
            hasError = true
            errorMessage = response.message
        }
    }
    
    // Clear error state
    func clearError() {
        hasError = false
        errorMessage = nil
    }
}
