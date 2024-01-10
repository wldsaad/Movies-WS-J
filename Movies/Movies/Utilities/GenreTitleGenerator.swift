//
//  GenreTitleGenerator.swift
//  Movies
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation
import Domain

struct GenreTitleGenerator {
    
    func callAsFunction(_ genres: MovieGenres?) -> String {
        MovieListFormatter()(genres?.map { $0.name })
    }
}
