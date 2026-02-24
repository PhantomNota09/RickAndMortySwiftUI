//
//  Models.swift
//  RickAndMortySwiftUI
//
//  Created by Surya Rayala on 2/24/26.
//

import Foundation

// MARK: - Character Response
// This is what we get back from the API
struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Info
// Contains pagination information
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Character
// Represents a single Rick and Morty character
struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Origin
// Represents where the character is from
struct Origin: Codable {
    let name: String
    let url: String
}

// MARK: - Location
// Represents the character's current location
struct Location: Codable {
    let name: String
    let url: String
}
