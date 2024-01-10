//
//  LocalRepository.swift
//  MockDataSource
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

public protocol LocalRepository {

    mutating func getData<Value: Codable>() async throws -> Value
}
