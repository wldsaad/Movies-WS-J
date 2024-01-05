//
//  TrendingMoviesApi.swift
//  Repository
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation

enum TrendingMoviesApi {
    
    case getTrendingMovies(page: Int)
}

extension TrendingMoviesApi: APIRequest {
    
    var path: String {
        switch self {
        case .getTrendingMovies: #"/discover/movie"#
        }
    }
    
    var method: APIRequestMethod {
        switch self {
        case .getTrendingMovies: .get
        }
    }
    
    var query: [String: String]? {
        switch self {
        case let .getTrendingMovies(page):
            [
                "include_adult": String(false),
                "sort_by": "popularity.desc",
                "page": String(page)
            ]
        }
    }
}
