//
//  MovieGenresDTOMapper.swift
//  Repository
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation
import Domain

struct MovieGenresDTOMapper {
    
    // MARK: - Properties
    
    private let response: MovieGenresResponse
    
    // MARK: - Init
    
    init(response: MovieGenresResponse) {
        self.response = response
    }
    
    // MARK: - APIs
    
    func callAsFunction() -> MovieGenres {
        response.genres?.compactMap { .init(id: $0.id, name: $0.name) } ?? []
    }
}
