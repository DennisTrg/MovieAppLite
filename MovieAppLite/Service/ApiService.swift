//
//  ApiService.swift
//  MovieAppLite
//
//  Created by Tung Truong on 28/12/2022.
//

import Foundation


class ApiService{
    static func ImageUrlString(imagePath: String) -> String{
        return "https://image.tmdb.org/t/p/original/\(imagePath)"
    }
    
    static func urlString(category: String, page: Int) -> String{
        return "https://api.themoviedb.org/3/movie/\(category)?api_key=\(APIKey)&page=\(page)"
    }
}
