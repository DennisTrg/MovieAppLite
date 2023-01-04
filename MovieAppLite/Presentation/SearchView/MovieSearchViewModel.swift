//
//  MovieSearchViewModel.swift
//  MovieAppLite
//
//  Created by Tung Truong on 04/01/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class MovieSearchViewModel{
    
    private let apiService: ApiServiceDelegate
    let movieDetail = BehaviorRelay<[HomeListMovie]>(value: [])
    init(apiService: ApiServiceDelegate = ApiService()){
        self.apiService = apiService
    }
    
    func fetchMovieResult(keyword: String, page: Int){
        if keyword.count == 0{
            return
        }
        
        let url = ApiService.configureUrlString(keyword: keyword, page: page)
        apiService.fetchRequest(url: url).map { movieList -> [MovieListResult] in
            guard let movieListResult = movieList.results else {return []}
            return movieListResult
        }.map { movieResult in
            movieResult.map {HomeListMovie.convertMovieToFormat(movieInfo: $0)}
       }.take(1)
            .bind(to:movieDetail)
    }
}
