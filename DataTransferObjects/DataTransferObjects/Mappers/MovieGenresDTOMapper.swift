//
//  MovieGenresDTOMapper.swift
//  DataTransferObjects
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation
import Domain

public struct MovieGenresDTOMapper {
    
    // MARK: - Properties
    
    private let response: MovieGenresResponse
    
    // MARK: - Init
    
    public init(response: MovieGenresResponse) {
        self.response = response
    }
    
    // MARK: - APIs
    
    public func callAsFunction() -> MovieGenres {
        response.genres?.filter { $0.id != nil }.compactMap { .init(id: $0.id!, name: $0.name) } ?? []
    }
}
