//
//  MovieGenresUseCase.swift
//  Domain
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

public protocol MovieGenresUseCase {
    
    mutating func execute() async throws -> MovieGenres
}
