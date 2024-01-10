//
//  MockDataSource.swift
//  MockDataSource
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

public struct MockDataSource: LocalRepository {
    
    // MARK: - Properties
    
    private let json: String?
    
    // MARK: - Init
    
    public init(json: String?) {
        self.json = json
    }
    
    // MARK: - APIs
    
    public func getData<Value: Codable>() async throws -> Value {
        return try LocalJsonParser().getData(json: json)
    }
}
