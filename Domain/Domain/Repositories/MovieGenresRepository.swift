//
//  MovieGenresRepository.swift
//  Domain
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

public protocol MovieGenresRepository {
    
    mutating func execute() async throws -> MovieGenres
}
