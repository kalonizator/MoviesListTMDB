//
//  ApiRouter.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    //The endpoint name we'll call later
    case getTrendingMovies
    case getSimilarMoviesList(movieId: Int)
    case searchMovie(movieName: String)
    case getGenres
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .getTrendingMovies:
            return .get
        case .getSimilarMoviesList:
            return .get
        case .searchMovie:
            return .get
        case .getGenres:
            return .get
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    private var path: String {
        switch self {
        case .getTrendingMovies:
            return "/trending/all/day"
        case .getSimilarMoviesList(let movieId):
            return "/movie/\(movieId)/similar"
        case .searchMovie:
            return "/search/movie"
        case .getGenres:
            return "/genre/movie/list"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    private var parameters: Parameters? {
        switch self {
        case .getTrendingMovies:
            //A dictionary of the key (From the constants file) and its value is returned
            return [Constants.Parameters.apiKey : "02da584cad2ae31b564d940582770598"]
        case .getSimilarMoviesList:
            return [
                Constants.Parameters.apiKey : "02da584cad2ae31b564d940582770598"
            ]
        case .searchMovie(let movieName):
            return [
                Constants.Parameters.apiKey : "02da584cad2ae31b564d940582770598",
                "query" : movieName
            ]
        case .getGenres:
            //A dictionary of the key (From the constants file) and its value is returned
            return [Constants.Parameters.apiKey : "02da584cad2ae31b564d940582770598"]
        }
    }
}
