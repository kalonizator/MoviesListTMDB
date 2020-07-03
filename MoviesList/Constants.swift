//
//  Constants.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator. All rights reserved.
//

import Foundation

struct Constants {
    
    //The API's base URL
    static let baseUrl = "https://api.themoviedb.org/3"
    
    //The parameters (Queries) that we're gonna use
    struct Parameters {
        static let apiKey = "api_key"
    }
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}
