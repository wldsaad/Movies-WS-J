//
//  MovieDetailsRepositoryImplementation.swift
//  Repository
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation
import Domain

public struct MovieDetailsRepositoryImplementation: MovieDetailsRepository {
    
    // MARK: - Properties
    
    private var repository: Repository
    
    // MARK: - Init
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - APIs
    
    mutating public func execute(id: Int) async throws -> MovieDetails {
        let api = MovieDetailsApi(id: id)
        let response: MovieDetailsResponse = try await repository.getData(api: api, cachePolicy: .never)
        return MovieDetailsDTOMapper(response: response)()
    }
}
