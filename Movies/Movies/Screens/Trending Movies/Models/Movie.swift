//
//  Movie.swift
//  Movies
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation
import SwiftData
import Domain

@Model
final class Movie {
    
    // MARK: - Properties
    
    let id = UUID()
    let title: String
    let image: String
    let releaseDate: String
    
    // MARK: - Init
    
    init(title: String, image: String, releaseDate: String) {
        self.title = title
        self.image = image
        self.releaseDate = releaseDate
    }
    
    init(movie: TrendingMovie) {
        title = movie.title ?? ""
        image = movie.image ?? ""
        releaseDate = {
            if let releaseDate = movie.releaseDate {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy"
                return formatter.string(from: releaseDate)
            }
            
            return ""
        }()
    }
}
