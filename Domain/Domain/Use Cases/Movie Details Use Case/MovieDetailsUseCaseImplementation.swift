//
//  MovieDetailsUseCaseImplementation.swift
//  Domain
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

public struct MovieDetailsUseCaseImplementation: MovieDetailsUseCase {
    
    // MARK: - Properties
    
    private var repository: MovieDetailsRepository
    
    // MARK: - Init
    
    public init(repository: MovieDetailsRepository) {
        self.repository = repository
    }
    
    // MARK: - APIs
    
    mutating public func execute(id: Int) async throws -> MovieDetails {
        try await repository.execute(id: id)
    }
}
