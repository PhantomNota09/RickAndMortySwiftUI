//
//  Constants.swift
//  RickAndMortySwiftUI
//
//  Created by Surya Rayala on 2/24/26.
//

enum Server : String {
    case urlString = "https://rickandmortyapi.com/api/character/?name="
}

// Error Message
enum APIError {
    case invalidURL
    case empty
    case failed
    case success([Character])

    var message: String {
        switch self {
        case .invalidURL: 
            return "Invalid URL. Please try again."
        case .empty:
            return "No characters found."
        case .failed:
            return "Failed to load data. Please try again."
        case .success:
            return ""
        }
    }
}
