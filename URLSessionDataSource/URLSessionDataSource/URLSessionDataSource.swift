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
        let (data, response) = try await urlSession.data(for: urlRequest)
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        if statusCode?.isSuccessUrlStatusCode ?? false {
            return try DefaultJsonDecoder().decode(Value.self, from: data)
        } else {
            throw NSError(domain: urlRequest.url?.absoluteString ?? "", code: statusCode ?? -1001)
        }
    }
}

extension Int {
    
    var isSuccessUrlStatusCode: Bool {
        (200..<300) ~= self
    }
}
