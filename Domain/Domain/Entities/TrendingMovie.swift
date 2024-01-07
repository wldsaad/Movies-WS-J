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
    
    public let id: Int
    public let title: String?
    public let thumbnail: String?
    public let releaseDate: Date?
    public let genreIds: [Int]?

    public init(id: Int, title: String?, thumbnail: String?, releaseDate: Date?, genreIds: [Int]?) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
}
