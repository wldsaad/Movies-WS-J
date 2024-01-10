//
//  MovieDetailsResponse.swift
//  Repository
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

struct MovieDetailsResponse: Codable {
    
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let budget: Double?
    let revenue: Double?
    let genres: [MovieGenre]?
    let homepage: String?
    let originalTitle: String?
    let title: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: Date?
    let runtime: Double?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let video: Bool?
    let popularity: Double?
    let voteAverage: Double?
    let voteCount: Int?
}

struct SpokenLanguage: Codable {
    
    let englishName: String?
    let name: String?
}
