// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let genresModel = try? newJSONDecoder().decode(GenresModel.self, from: jsonData)

import Foundation

// MARK: - GenresModel
struct GenresModel: Codable {
    internal init(genres: [Genre]? = nil) {
        self.genres = genres
    }
    
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    internal init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
    let id: Int?
    let name: String?
}
