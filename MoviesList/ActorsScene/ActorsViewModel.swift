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
    var movieId: Int!
    
    // Outputs
    var loading: Driver<Bool>
    var actors: Driver<[ActorViewModel]>
    var selectedActorId: Driver<Int>
    
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService, movieId: Int) {
        self.networkingService = networkingService
        self.movieId = movieId
        
        let loading = ActivityIndicator()
        self.loading = loading.asDriver()
        
        let initialGenres = self.viewWillAppearSubject
            .asObservable()
            .flatMap { _ in
                networkingService
                    .getMovieCast(movieId: movieId)
                    .trackActivity(loading)
            }
            .asDriver(onErrorJustReturn: MovieCastModel())

        let actors = Driver.merge(initialGenres)
        self.actors = actors.map({ (result) -> [ActorViewModel] in
            var actorsArray : [ActorViewModel] = []
            for actor in result.cast ?? [] {
                actorsArray.append(ActorViewModel(name: actor.name, actorAvatarPath: actor.profilePath))
            }
            return actorsArray
        })
        
//        self.repos = repos.map { $0.results.map { RepoViewModel(repo: $0)} }
        
        self.selectedActorId = self.selectedIndexSubject
            .asObservable()
            .withLatestFrom(actors) { (indexPath, genres) in
                return genres.cast?[indexPath.row]
            }
        .map { $0?.id ?? 0 }
            .asDriver(onErrorJustReturn: 0)
    }
}

struct ActorViewModel {
    let name: String?
    let actorAvatarPath: String?
}

extension ActorViewModel {
    init(cast: Cast) {
        self.name = cast.name
        self.actorAvatarPath = cast.profilePath
    }
}
