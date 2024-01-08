//
//  TrendingMoviesUseCaseImplementation.swift
//  Domain
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation

public struct TrendingMoviesUseCaseImplementation: TrendingMoviesUseCase {
    
    // MARK: - Properties
    
    private var repository: TrendingMoviesRepository
    
    // MARK: - Init
    
    public init(repository: TrendingMoviesRepository) {
        self.repository = repository
    }
    
    // MARK: - APIs
    
    mutating public func execute(page: Int) async throws -> TrendingMovies {
        try await repository.execute(page: page)
    }
}
