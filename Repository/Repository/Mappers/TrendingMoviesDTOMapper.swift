//
//  TrendingMoviesDTOMapper.swift
//  Repository
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation
import Domain

struct TrendingMoviesDTOMapper {

    // MARK: - Properties
    
    private let response: TrendingMoviesResponse
    
    // MARK: - Init
    
    init(response: TrendingMoviesResponse) {
        self.response = response
    }
    
    // MARK: - APIs
    
    func callAsFunction() -> TrendingMovies {
        let movies: [TrendingMovie] = response.results?.compactMap { .init(title: $0.title, image: $0.backdropPath, releaseDate: $0.releaseDate) } ?? []
        let pagination = Pagination(page: response.page, totalPages: response.totalPages, totalResults: response.totalResults)
        return .init(movies: movies, pagination: pagination)
    }
}
