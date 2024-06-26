//
//  RemoteRepository.swift
//  Repository
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation

public protocol RemoteRepository {

    mutating func getData<Value: Codable>(api: APIRequest) async throws -> Value
}
