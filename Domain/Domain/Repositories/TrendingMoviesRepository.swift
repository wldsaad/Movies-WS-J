//
//  TrendingMoviesRepository.swift
//  Domain
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation

public protocol TrendingMoviesRepository {
    
    mutating func execute(page: Int) async throws -> TrendingMovies
}
