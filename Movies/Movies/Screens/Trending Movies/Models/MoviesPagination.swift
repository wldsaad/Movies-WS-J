//
//  MoviesPagination.swift
//  Movies
//
//  Created by Waleed Saad on 08/01/2024.
//

import Foundation
import SwiftData
import Domain

@Model
final class MoviesPagination {
    
    // MARK: - Properties
    
    let currentPage: Int
    let totalPages: Int
    let totalResults: Int
    
    // MARK: - Init
    
    init(currentPage: Int, totalPages: Int, totalResults: Int) {
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
    
    init(_ pagination: Pagination) {
        self.currentPage = pagination.page
        self.totalPages = pagination.totalPages
        self.totalResults = pagination.totalResults
    }
}
