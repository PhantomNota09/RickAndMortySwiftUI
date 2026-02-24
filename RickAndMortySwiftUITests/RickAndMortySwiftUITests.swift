//
//  RickAndMortySwiftUITests.swift
//  RickAndMortySwiftUITests
//
//  Created by Surya Rayala on 2/24/26.
//

import XCTest
@testable import RickAndMortySwiftUI

final class RickAndMortySwiftUITests: XCTestCase {

    // Test 1: Check if Character model can be decoded from JSON
    func testCharacterDecoding() throws {
        let json = """
        {
            "id": 1,
            "name": "Rick Sanchez",
            "status": "Alive",
            "species": "Human",
            "type": "",
            "gender": "Male",
            "origin": {
                "name": "Earth (C-137)",
                "url": "https://rickandmortyapi.com/api/location/1"
            },
            "location": {
                "name": "Citadel of Ricks",
                "url": "https://rickandmortyapi.com/api/location/3"
            },
            "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            "episode": ["https://rickandmortyapi.com/api/episode/1"],
            "url": "https://rickandmortyapi.com/api/character/1",
            "created": "2017-11-04T18:48:46.250Z"
        }
        """
        
        let data = json.data(using: .utf8)!
        let character = try JSONDecoder().decode(Character.self, from: data)
        
        XCTAssertEqual(character.id, 1)
        XCTAssertEqual(character.name, "Rick Sanchez")
        XCTAssertEqual(character.status, "Alive")
        XCTAssertEqual(character.species, "Human")
        XCTAssertEqual(character.origin.name, "Earth (C-137)")
    }
    
    // Test 2: Test that Character is Identifiable
    func testCharacterIsIdentifiable() throws {
        let json = """
        {
            "id": 42,
            "name": "Test Character",
            "status": "Alive",
            "species": "Human",
            "type": "",
            "gender": "Male",
            "origin": {"name": "Earth", "url": ""},
            "location": {"name": "Earth", "url": ""},
            "image": "test.jpeg",
            "episode": [],
            "url": "",
            "created": "2017-11-04T18:48:46.250Z"
        }
        """
        
        let data = json.data(using: .utf8)!
        let character = try JSONDecoder().decode(Character.self, from: data)
        
        XCTAssertEqual(character.id, 42)
    }
    
    // Test 3: Test CharacterResponse decoding
    func testCharacterResponseDecoding() throws {
        let json = """
        {
            "info": {
                "count": 1,
                "pages": 1,
                "next": null,
                "prev": null
            },
            "results": [
                {
                    "id": 1,
                    "name": "Rick Sanchez",
                    "status": "Alive",
                    "species": "Human",
                    "type": "",
                    "gender": "Male",
                    "origin": {"name": "Earth", "url": ""},
                    "location": {"name": "Earth", "url": ""},
                    "image": "test.jpeg",
                    "episode": [],
                    "url": "",
                    "created": "2017-11-04T18:48:46.250Z"
                }
            ]
        }
        """
        
        let data = json.data(using: .utf8)!
        let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
        
        XCTAssertEqual(response.info.count, 1)
        XCTAssertEqual(response.results.count, 1)
        XCTAssertEqual(response.results.first?.name, "Rick Sanchez")
    }
}
