//
//  ApiService.swift
//  MovieAppLite
//
//  Created by Tung Truong on 28/12/2022.
//

import Foundation
import RxSwift

protocol ApiServiceDelegate{
    func fetchRequest(url: String) -> Observable<MovieList>
}

class ApiService{
    static func ImageUrlString(imagePath: String) -> String{
        return "https://image.tmdb.org/t/p/original/\(imagePath)"
    }
    
    static func urlString(category: String, page: Int) -> String{
        return "https://api.themoviedb.org/3/movie/\(category)?api_key=\(APIKey)&page=\(page)"
    }
}

extension ApiService: ApiServiceDelegate{
    func fetchRequest(url: String) -> Observable<MovieList>{
        return Observable.create { observer -> Disposable in
            //retrieve data from URL
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                if let error = error {
                    observer.onError(error)
                }
                guard let data = data else {
                    let response = response as? HTTPURLResponse
                    observer.onError(NSError(domain: "No Data", code: response?.statusCode ?? -1, userInfo: nil))
                    return
                }
            
                do {
                    //decode data
                    let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                    observer.onNext(movieList)
                } catch{
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
