//
//  DefaultRemoteDataSource.swift
//  Repository
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation

public struct DefaultRemoteDataSource: RemoteDataSource {

    // MARK: - Init
    
    public init() {}

    // MARK: - APIs
    
    public mutating func getData<Value: Codable>(api: APIRequest) async throws -> Value {
        fatalError("Implement remote data source!")
    }
}
