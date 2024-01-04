//
//  Repository.swift
//  Repository
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation

public protocol Repository {

    mutating func getData<Value: Codable>(api: APIRequest, cachePolicy: CachePolicy) async throws -> Value
}
