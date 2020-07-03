// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieModel = try? newJSONDecoder().decode(MovieModel.self, from: jsonData)

import Foundation

// MARK: - MovieModel
struct MovieRequestModel: Codable {
    internal init(page: Int? = nil, results: [Movie]? = nil, totalPages: Int? = nil, totalResults: Int? =  nil, statusCode: Int? = nil, statusMessage: String? = nil) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
        self.statusCode = statusCode
        self.statusMessage = statusMessage
    }
    
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?
    let statusCode: Int?
    let statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    internal init(originalName: String? = nil, id: Int? = nil, name: String? = nil, voteCount: Int? = nil, voteAverage: Double? = nil, firstAirDate: String? = nil, posterPath: String? = nil, genreIDS: [Int]? = nil, originalLanguage: String? = nil, backdropPath: String? = nil, overview: String? = nil, originCountry: [String]? = nil, popularity: Double? = nil, mediaType: String? = nil, adult: Bool? = nil, originalTitle: String? = nil, releaseDate: String? = nil, title: String? = nil, video: Bool? = nil) {
        self.originalName = originalName
        self.id = id
        self.name = name
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.firstAirDate = firstAirDate
        self.posterPath = posterPath
        self.genreIDS = genreIDS
        self.originalLanguage = originalLanguage
        self.backdropPath = backdropPath
        self.overview = overview
        self.originCountry = originCountry
        self.popularity = popularity
        self.mediaType = mediaType
        self.adult = adult
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
    }
    
    let originalName: String?
    let id: Int?
    let name: String?
    let voteCount: Int?
    let voteAverage: Double?
    let firstAirDate, posterPath: String?
    let genreIDS: [Int]?
    let originalLanguage: String?
    let backdropPath, overview: String?
    let originCountry: [String]?
    let popularity: Double?
    let mediaType: String?
    let adult: Bool?
    let originalTitle, releaseDate, title: String?
    let video: Bool?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case id, name
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case overview
        case originCountry = "origin_country"
        case popularity
        case mediaType = "media_type"
        case adult
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case title, video
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case de = "de"
    case en = "en"
    case es = "es"
    case it = "it"
}
