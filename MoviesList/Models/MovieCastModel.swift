// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieCastModel = try? newJSONDecoder().decode(MovieCastModel.self, from: jsonData)

import Foundation

// MARK: - MovieCastModel
struct MovieCastModel: Codable {
    internal init(id: Int? = nil, cast: [Cast]? = nil, crew: [Crew]? = nil) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }
    
    let id: Int?
    let cast: [Cast]?
    let crew: [Crew]?
}

// MARK: - Cast
struct Cast: Codable {
    internal init(castID: Int? = nil, character: String? = nil, creditID: String? = nil, gender: Int? = nil, id: Int? = nil, name: String? = nil, order: Int? = nil, profilePath: String? = nil) {
        self.castID = castID
        self.character = character
        self.creditID = creditID
        self.gender = gender
        self.id = id
        self.name = name
        self.order = order
        self.profilePath = profilePath
    }
    
    let castID: Int?
    let character, creditID: String?
    let gender, id: Int?
    let name: String?
    let order: Int?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
}

// MARK: - Crew
struct Crew: Codable {
    internal init(creditID: String? = nil, department: String? = nil, gender: Int? = nil, id: Int? = nil, job: String? = nil, name: String? = nil, profilePath: String? = nil) {
        self.creditID = creditID
        self.department = department
        self.gender = gender
        self.id = id
        self.job = job
        self.name = name
        self.profilePath = profilePath
    }
    
    let creditID, department: String?
    let gender, id: Int?
    let job, name, profilePath: String?

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
    }
}
