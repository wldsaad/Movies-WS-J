//
//  TrendingMoviesRepositoryImplementation.swift
//  Repository
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation
import Domain
import DataTransferObjects

public struct TrendingMoviesRepositoryImplementation: TrendingMoviesRepository {
    
    // MARK: - Properties
    
    private var repository: RemoteRepository
    
    // MARK: - Init
    
    public init(repository: RemoteRepository) {
        self.repository = repository
    }
    
    // MARK: - APIs
    
    mutating public func execute(page: Int) async throws -> TrendingMovies {
        let api = TrendingMoviesApi(page: page)
        let response: TrendingMoviesResponse = try await repository.getData(api: api)
        return TrendingMoviesDTOMapper(response: response)()
    }
}
