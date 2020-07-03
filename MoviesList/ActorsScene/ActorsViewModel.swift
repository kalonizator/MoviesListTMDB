//
//  ActorsViewModel.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator corp. All rights reserved.
//

import RxSwift
import RxCocoa

final class ActorsViewModel {
    // Inputs
    let viewWillAppearSubject = PublishSubject<Void>()
    let selectedIndexSubject = PublishSubject<IndexPath>()
    let searchQuerySubject = BehaviorSubject(value: "")
    
    // Outputs
    var loading: Driver<Bool>
    var repos: Driver<[GenreViewModel]>
    var selectedActorId: Driver<Int>
    
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
        
        let loading = ActivityIndicator()
        self.loading = loading.asDriver()
        
        let initialGenres = self.viewWillAppearSubject
            .asObservable()
            .flatMap { _ in
                networkingService
                    .getGenresList()
                    .trackActivity(loading)
            }
            .asDriver(onErrorJustReturn: GenresModel())

        let genres = Driver.merge(initialGenres)
        self.repos = genres.map({ (result) -> [GenreViewModel] in
            var genresArray : [GenreViewModel] = []
            for genre in result.genres ?? [] {
                genresArray.append(GenreViewModel(name: genre.name))
            }
            return genresArray
        })
        
//        self.repos = repos.map { $0.results.map { RepoViewModel(repo: $0)} }
        
        self.selectedActorId = self.selectedIndexSubject
            .asObservable()
            .withLatestFrom(genres) { (indexPath, genres) in
                return genres.genres?[indexPath.item]
            }
        .map { $0?.id ?? 0 }
            .asDriver(onErrorJustReturn: 0)
    }
}

struct ActorViewModel {
    let name: String?
}

extension ActorViewModel {
    init(genre: Genre) {
        self.name = genre.name
    }
}
