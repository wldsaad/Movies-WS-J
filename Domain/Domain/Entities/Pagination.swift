//
//  Pagination.swift
//  Domain
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation

public struct Pagination {
    
    public let page: Int
    public let totalPages: Int
    public let totalResults: Int
    
    public init(page: Int? = nil, totalPages: Int? = nil, totalResults: Int? = nil) {
        self.page = page ?? 0
        self.totalPages = totalPages ?? 0
        self.totalResults = totalResults ?? 0
    }
}
