//
//  MovieDetailsUseCase.swift
//  Domain
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

public protocol MovieDetailsUseCase {
    
    mutating func execute(id: Int) async throws -> MovieDetails
}
