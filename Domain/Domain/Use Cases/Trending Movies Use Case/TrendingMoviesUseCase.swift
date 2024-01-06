//
//  TrendingMoviesUseCase.swift
//  Domain
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation

public protocol TrendingMoviesUseCase {
    
    mutating func execute(page: Int) async throws -> TrendingMovies
}
