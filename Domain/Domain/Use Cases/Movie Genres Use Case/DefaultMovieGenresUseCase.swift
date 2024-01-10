//
//  DefaultMovieGenresUseCase.swift
//  Domain
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

public struct DefaultMovieGenresUseCase: MovieGenresUseCase {
    
    // MARK: - Properties
    
    private var repository: MovieGenresRepository
    
    // MARK: - Init
    
    public init(repository: MovieGenresRepository) {
        self.repository = repository
    }
    
    // MARK: - APIs
    
    mutating public func execute() async throws -> MovieGenres {
        try await repository.execute()
    }
}
