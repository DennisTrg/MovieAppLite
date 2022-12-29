//
//  HomeVcViewModel.swift
//  MovieAppLite
//
//  Created by Tung Truong on 29/12/2022.
//

import Foundation
import RxSwift
import RxRelay
class HomeVcViewModel{
    static let shared = HomeVcViewModel()
    
    func requestData(page: Int){
        let url = ApiService.urlString(category: "popular", page: page)
        let abc = ApiService.fetchDataRxSwift(url: url).map {movieList -> [MovieListResult] in
            guard let movieListResult = movieList.results else {return []}
            return movieListResult
        }
        print(abc)
        
    }
}
