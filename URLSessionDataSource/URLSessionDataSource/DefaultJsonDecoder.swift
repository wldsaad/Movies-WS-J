//
//  DefaultJsonDecoder.swift
//  URLSessionDataSource
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation

class DefaultJsonDecoder: JSONDecoder {
    
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
