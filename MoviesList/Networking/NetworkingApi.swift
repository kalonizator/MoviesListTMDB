//
//  NetworkingApi.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2019 kalonizator. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol NetworkingService {
    func getTrendingMovies() -> Observable<MovieRequestModel>
    func getSimilarMoviesList(movieId: Int) -> Observable<MovieRequestModel>
    func searchMovie(movieName: String) -> Observable<MovieRequestModel>
    func getGenresList() -> Observable<GenresModel>
}

final class NetworkingApi: NetworkingService {
    func getTrendingMovies() -> Observable<MovieRequestModel> {
        return ApiClient.getTrendingMovies()
    }
    func getSimilarMoviesList(movieId: Int) -> Observable<MovieRequestModel> {
        return ApiClient.getSimilarMoviesList(movieId: movieId)
    }
    func searchMovie(movieName: String) -> Observable<MovieRequestModel> {
        return ApiClient.searchMovie(movieName: movieName)
    }
    func getGenresList() -> Observable<GenresModel> {
        return ApiClient.getGenres()
    }
}
