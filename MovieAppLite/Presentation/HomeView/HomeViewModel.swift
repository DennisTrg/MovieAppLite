//
//  HomeVcViewModel.swift
//  MovieAppLite
//
//  Created by Tung Truong on 29/12/2022.
//

import Foundation
import RxSwift
import RxRelay

final class HomeViewModel{

    private let apiService: ApiServiceDelegate
    
    init(apiService: ApiServiceDelegate = ApiService()){
        self.apiService = apiService
    }
    
    func fetchMovieResult(page: Int) -> Observable<[MovieListResult]> {
        apiService.fetchRequest(url: ApiService.urlString(category: "popular", page: page)).map { movieList -> [MovieListResult] in
            guard let movieListResult = movieList.results else {return []}
            return movieListResult
        }
    }
}

