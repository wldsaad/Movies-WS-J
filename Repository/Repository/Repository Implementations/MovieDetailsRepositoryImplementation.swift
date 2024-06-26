//
//  MovieDetailsRepositoryImplementation.swift
//  Repository
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation
import Domain
import DataTransferObjects

public struct MovieDetailsRepositoryImplementation: MovieDetailsRepository {
    
    // MARK: - Properties
    
    private var repository: RemoteRepository
    
    // MARK: - Init
    
    public init(repository: RemoteRepository) {
        self.repository = repository
    }
    
    // MARK: - APIs
    
    mutating public func execute(id: Int) async throws -> MovieDetails {
        let api = MovieDetailsApi(id: id)
        let response: MovieDetailsResponse = try await repository.getData(api: api)
        return MovieDetailsDTOMapper(response: response)()
    }
}
