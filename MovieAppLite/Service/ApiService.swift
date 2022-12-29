//
//  ApiService.swift
//  MovieAppLite
//
//  Created by Tung Truong on 28/12/2022.
//

import Foundation
import RxSwift


class ApiService{
    static func ImageUrlString(imagePath: String) -> String{
        return "https://image.tmdb.org/t/p/original/\(imagePath)"
    }
    
    static func urlString(category: String, page: Int) -> String{
        return "https://api.themoviedb.org/3/movie/\(category)?api_key=\(APIKey)&page=\(page)"
    }
    
    static func fetchData(url: String, completionHandler: @escaping (Result<MovieList, Error>) -> Void){
        guard let url = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            guard let data = data else {
                let response = response as? HTTPURLResponse
                completionHandler(.failure(NSError(domain: "no data", code: response?.statusCode ?? -1, userInfo: nil)))
                return
            }
            do{
                let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                print(movieList)
                completionHandler(.success(movieList))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
}

extension ApiService{
    static func fetchDataRxSwift(url: String) -> Observable<MovieList>{
        return Observable.create { observer  in
            fetchData(url: url) { result in
                switch result{
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {}
        }
    }
}


