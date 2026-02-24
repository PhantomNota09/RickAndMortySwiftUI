# Rick and Morty Character Search App

A native iOS application built with SwiftUI that allows users to search for characters from the Rick and Morty TV series using the Rick and Morty API.

## Features

- **Real-time Search** - Search updates automatically as you type
- **Character List** - Displays character name, species, and image
- **Detail View** - Tap any character to see full details
- **Async/Await** - Modern Swift concurrency for network calls
- **SwiftUI** - Built entirely with SwiftUI
- **Unit Tests** - Includes test coverage

## Screenshots

### Main Search Screen
- Search bar at the top
- List of characters with images and basic info
- Loading indicator during search

### Detail Screen
- Full-width character image
- Species, Status, Origin information
- Type (if available)
- Created date

### Key Components

#### Models
- **Character**: Represents a single character with all properties
- **CharacterResponse**: API response wrapper containing results and pagination info
- **Origin/Location**: Nested models for character origin and location

#### NetworkManager
- Handles all HTTP requests to the Rick and Morty API
- Uses Swift's async/await for asynchronous operations
- Decodes JSON responses into Swift models

#### CharacterViewModel
- Uses `@Observable` macro (Swift 5.9+)
- Manages search state and character data
- Handles loading states and errors
- Converts search text to lowercase for API compatibility

#### Views
- **ContentView**: Main screen with search bar and character list
- **CharacterDetailView**: Detail screen showing full character information
- Uses `AsyncImage` for loading images from URLs
- `NavigationStack` for navigation between screens

## Example
![Simulator Screen Recording - iPhone 17 Pro - 2026-02-24 at 08 35 42](https://github.com/user-attachments/assets/45b298be-ab05-4c40-b6b5-46b003450485)

