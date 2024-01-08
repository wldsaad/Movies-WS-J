//
//  RepositoryImplementation.swift
//  Repository
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation

public class RepositoryImplementation: Repository {

    // MARK: - Properties
    
    public static let shared = RepositoryImplementation()

    private var remoteRepository: DataSource
    
    // MARK: - Init
    
    private init() {
        remoteRepository = RemoteDataSource()
    }
    
    // MARK: - APIs
    
    public func getData<Value: Codable>(api: APIRequest) async throws -> Value {
        try await remoteRepository.getData(api: api)
    }
}
