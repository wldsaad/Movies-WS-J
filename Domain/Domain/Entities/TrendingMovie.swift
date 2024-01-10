//
//  TrendingMovie.swift
//  Domain
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation

public struct TrendingMovies {
    
    public let movies: [TrendingMovie]
    
    public let pagination: Pagination
    
    public init(movies: [TrendingMovie], pagination: Pagination) {
        self.movies = movies
        self.pagination = pagination
    }
}

public struct TrendingMovie {
    
    public let title: String?
    public let image: String?
    public let releaseDate: Date?
    public let genreIds: [Int]?

    public init(title: String?, image: String?, releaseDate: Date?, genreIds: [Int]?) {
        self.title = title
        self.image = image
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
}
