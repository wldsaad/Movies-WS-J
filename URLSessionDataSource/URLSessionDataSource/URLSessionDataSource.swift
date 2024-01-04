//
//  URLSessionDataSource.swift
//  URLSessionDataSource
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation

public struct URLSessionDataSource {
    
    private let urlSession = URLSession.shared
    
    public init() {}
    
    public func getData<Value: Codable>(urlRequest: URLRequest) async throws -> Value {
        let (data, _) = try await urlSession.data(for: urlRequest)
        return try JSONDecoder().decode(Value.self, from: data)
    }
}
