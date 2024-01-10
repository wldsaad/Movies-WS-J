//
//  LocalJsonParser.swift
//  MockDataSource
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

class LocalJsonParser {
    
    func getData<Value: Codable>(json: String?) throws -> Value {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: json, withExtension: "json") else { fatalError("Json file is not in the bundle") }
        
        do {
            let data = try Data(contentsOf: url)
            return try MockJsonDecoder().decode(Value.self, from: data)
        } catch { throw error }
    }
}

fileprivate class MockJsonDecoder: JSONDecoder {
    
    override init() {
        super.init()
        
        allowsJSON5 = true
        keyDecodingStrategy = .convertFromSnakeCase
        dateDecodingStrategy = .formatted({
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter
        }())
    }
}
