//
//  TrendingMoviesApi.swift
//  Repository
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation

struct TrendingMoviesApi: APIRequest {
    
    // MARK: - Properties
    
    let path = #"/discover/movie"#
    
    let method: APIRequestMethod = .get
    
    var query: [String: String]? {
        [
            "include_adult": String(false),
            "sort_by": "popularity.desc",
            "page": String(page)
        ]
    }
    
    private let page: Int
    
    // MARK: - Init
    
    init(page: Int) {
        self.page = page
    }
}
