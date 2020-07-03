//
//  ApiClient.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator. All rights reserved.
//

import Alamofire
import RxSwift

class ApiClient {
    
    static func getTrendingMovies() -> Observable<MovieRequestModel> {
        return request(ApiRouter.getTrendingMovies)
    }
    
    static func getSimilarMoviesList(movieId: Int) -> Observable<MovieRequestModel> {
        return request(ApiRouter.getSimilarMoviesList(movieId: movieId))
    }
    
    static func searchMovie(movieName: String) -> Observable<MovieRequestModel> {
        if movieName.count < 1 {
            return request(ApiRouter.getTrendingMovies)
        } else {
            return request(ApiRouter.searchMovie(movieName: movieName))
        }
    }
    
    static func getGenres() -> Observable<GenresModel> {
        return request(ApiRouter.getGenres)
    }
    
    //-------------------------------------------------------------------------------------------------
    //MARK: - The request function to get results in an Observable
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<T>.create { observer in
            //Trigger the HttpRequest using AlamoFire (AF)
//            print(urlConvertible.urlRequest?.url?.absoluteString)
            let request = AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                //Check the result from Alamofire's response and check if it's a success or a failure
                switch response.result {
                case .success(let value):
                    //Everything is fine, return the value in onNext
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    //Something went wrong, switch on the status code and return the error
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(ApiError.forbidden)
                    case 404:
                        observer.onError(ApiError.notFound)
                    case 409:
                        observer.onError(ApiError.conflict)
                    case 500:
                        observer.onError(ApiError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
