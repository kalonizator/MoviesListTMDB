//
//  MovieDetailsViewModel.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator corp. All rights reserved.
//

import RxSwift
import RxCocoa

final class MoviesDetailsViewModel {
    // Inputs
    let viewWillAppearSubject = PublishSubject<Void>()
    let selectedIndexSubject = PublishSubject<IndexPath>()
    let searchQuerySubject = BehaviorSubject(value: "")
    var movieId : Int!
    
    // Outputs
    var loading: Driver<Bool>
    var repos: Driver<MovieViewModel>
    
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService, movieId: Int) {
        self.networkingService = networkingService
        self.movieId = movieId
        
        let loading = ActivityIndicator()
        self.loading = loading.asDriver()
        
        let initialMovies = self.viewWillAppearSubject
            .asObservable()
            .flatMap { _ in
                networkingService
                    .getMovieDetails(movieId: movieId)
                    .trackActivity(loading)
            }
            .asDriver(onErrorJustReturn: Movie())

        let movies = Driver.merge(initialMovies)
        self.repos = movies.map({ (result) -> MovieViewModel in
            return MovieViewModel(name: result.name, imagePath: result.posterPath)
        })
    }
}

//struct MovieDetailsViewModel {
//    let name: String?
//    var imagePath: String?
//}
//
//extension MovieViewModel {
//    init(movie: Movie) {
//        self.name = movie.name
//        self.imagePath = movie.posterPath
//    }
//}
