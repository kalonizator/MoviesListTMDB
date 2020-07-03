//
//  SimilarMoviesViewModel.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator corp. All rights reserved.
//

import RxSwift
import RxCocoa

final class SimilarMoviesViewModel {
    // Inputs
    let viewWillAppearSubject = PublishSubject<Void>()
    let selectedIndexSubject = PublishSubject<IndexPath>()
    let searchQuerySubject = BehaviorSubject(value: "")
    var movieId: Int!
    
    // Outputs
    var loading: Driver<Bool>
    var movie: Driver<[MovieViewModel]>
    var selectedMovieId: Driver<Int>
    
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService, movieId: Int) {
        self.movieId = movieId
        self.networkingService = networkingService
        
        let loading = ActivityIndicator()
        self.loading = loading.asDriver()
        
        let initialMovies = self.viewWillAppearSubject
            .asObservable()
            .flatMap { _ in
                networkingService
                    .getSimilarMoviesList(movieId: movieId)
                    .trackActivity(loading)
            }
            .asDriver(onErrorJustReturn: MovieRequestModel())
        
        let searchMovies = self.searchQuerySubject
            .asObservable()
//            .filter { $0.count > 2}
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query in
                networkingService
                    .searchMovie(movieName: query)
                    .trackActivity(loading)
            }
            .asDriver(onErrorJustReturn: MovieRequestModel())

        let movies = Driver.merge(initialMovies, searchMovies)
        self.movie = movies.map({ (result) -> [MovieViewModel] in
            var movieArray : [MovieViewModel] = []
            for movie in result.results ?? [] {
                movieArray.append(MovieViewModel(movie: movie))
            }
            return movieArray
        })
        
//        self.repos = repos.map { $0.results.map { RepoViewModel(repo: $0)} }
        
        self.selectedMovieId = self.selectedIndexSubject
            .asObservable()
            .withLatestFrom(movies) { (indexPath, movies) in
                return movies.results?[indexPath.item]
            }
        .map { $0?.id ?? 0 }
            .asDriver(onErrorJustReturn: 0)
    }
}
