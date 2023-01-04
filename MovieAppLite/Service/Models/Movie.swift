//
//  Movie.swift
//  MovieAppLite
//
//  Created by Tung Truong on 28/12/2022.
//

import Foundation

struct MovieList: Codable{
    let page: Int?
    let results: [MovieListResult]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieListResult: Codable{
    let adult: Bool?
    let backdropPath: String?
    let genreID: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreID = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct HomeListMovie: Codable{
    let originalTitle: String?
    let posterPath: String?
    let genre: String?
    let releaseDate: String?
    let ratingScore: Double
}

extension HomeListMovie{
    static func convertMovieToFormat(movieInfo: MovieListResult) -> HomeListMovie{
        
        return HomeListMovie(originalTitle: movieInfo.originalTitle, posterPath: movieInfo.posterPath, genre: {() -> String in
            if let genreID = movieInfo.genreID{
                var genre: [String] = []
                genreID.map { id in
                    _ = genreCode.map({ (key,value) in
                        if key == id { genre.append(value)}
                    })}
                
                return genre.joined(separator: ", ")
            }
                return ""
        }(), releaseDate: movieInfo.releaseDate, ratingScore: movieInfo.voteAverage ?? 0)
    }
}

let genreCode = [
    28 : "Action",
    12 : "Adventure",
    16 : "Animation",
    35 : "Comedy",
    80 : "Crime",
    99 : "Documentary",
    18 : "Drama",
    10751 : "Family",
    14 : "Fantasy",
    36 : "History",
    27 : "Horror",
    10402 : "Music",
    9648 : "Mystery",
    10749 : "Romance",
    878 : "Science Fiction",
    10770 : "TV Movie",
    53 : "Thriller",
    10752 : "War",
    37 : "Western"
]
