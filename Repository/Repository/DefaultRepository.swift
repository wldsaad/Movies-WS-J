//
//  DefaultRepository.swift
//  Repository
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation

public class DefaultRepository {

    // MARK: - Properties
    
    public static let shared = DefaultRepository()

    public var repository: Repository

    // MARK: - Init
    
    private init() {
        let localDataSource = DefaultLocalDataSource()
        let remoteDataSource = DefaultRemoteDataSource()
        repository = DefaultCacheRepository(localRepository: localDataSource, remoteRepository: remoteDataSource)
    }
}
