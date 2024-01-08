//
//  RemoteDataSource.swift
//  Repository
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation
import URLSessionDataSource

public struct RemoteDataSource: DataSource {

    // MARK: - Properties
    
    private let urlSessionDataSource = URLSessionDataSource()
    
    // MARK: - Init
    
    public init() {}

    // MARK: - APIs
    
    public mutating func getData<Value: Codable>(api: APIRequest) async throws -> Value {
        try await urlSessionDataSource.getData(urlRequest: api.urlRequest)
    }
}
