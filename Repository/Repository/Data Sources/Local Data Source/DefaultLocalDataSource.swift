//
//  DefaultLocalDataSource.swift
//  Repository
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation

public struct DefaultLocalDataSource: LocalDataSource {

    // MARK: - Init
    
    public init() {}

    // MARK: - APIs
    
    public func getData<Value: Codable>(api: APIRequest) async throws -> Value {
        fatalError("Local datasource is not implemented!")
    }

    public func saveValue<Value: Codable>(key: String, value: Value) {
        fatalError("Local datasource is not implemented!")
    }
}
