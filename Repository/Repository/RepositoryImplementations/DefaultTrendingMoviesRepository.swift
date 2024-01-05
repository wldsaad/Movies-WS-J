//
//  DefaultTrendingMoviesRepository.swift
//  Repository
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation
import Domain

public struct DefaultTrendingMoviesRepository: TrendingMoviesRepository {
    
    // MARK: - Properties
    
    private var repository: Repository
    
    // MARK: - Init
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - APIs
    
    mutating public func execute(page: Int) async throws -> TrendingMovies {
        let api = TrendingMoviesApi.getTrendingMovies(page: page)
        let response: TrendingMoviesResponse = try await repository.getData(api: api, cachePolicy: .never)
        return TrendingMoviesDTOMapper(response: response)()
    }
}
