//
//  TrendingMoviesDTOMapper.swift
//  DataTransferObjects
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation
import Domain

public struct TrendingMoviesDTOMapper {

    // MARK: - Properties
    
    private let response: TrendingMoviesResponse
    
    // MARK: - Init
    
    public init(response: TrendingMoviesResponse) {
        self.response = response
    }
    
    // MARK: - APIs
    
    public func callAsFunction() -> TrendingMovies {
        let imagePathFactory = ImagePathFactory()
        
        let movies: [TrendingMovie] = response.results?.filter { $0.id != nil }.compactMap { .init(
            id: $0.id!,
            title: $0.title,
            thumbnail: imagePathFactory.imagePath($0.backdropPath, imagePath: .thumbnail),
            releaseDate: $0.releaseDate,
            genreIds: $0.genreIds)
        } ?? []
        
        let pagination = Pagination(page: response.page, totalPages: response.totalPages, totalResults: response.totalResults)
        
        return .init(movies: movies, pagination: pagination)
    }
}

