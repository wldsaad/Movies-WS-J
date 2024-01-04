//
//  LocalDataSource.swift
//  Repository
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation

public protocol LocalDataSource: DataSource {

    mutating func saveValue<Value: Codable>(key: String, value: Value) async
}
