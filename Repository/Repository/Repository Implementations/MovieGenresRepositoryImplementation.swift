//
//  MovieGenresRepositoryImplementation.swift
//  Repository
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation
import Domain

public struct MovieGenresRepositoryImplementation: MovieGenresRepository {
    
    // MARK: - Properties
    
    private var repository: Repository
    
    // MARK: - Init
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - APIs
    
    mutating public func execute() async throws -> MovieGenres {
        let response: MovieGenresResponse = try await repository.getData(api: MovieGenresApi())
        return MovieGenresDTOMapper(response: response)()
    }
}