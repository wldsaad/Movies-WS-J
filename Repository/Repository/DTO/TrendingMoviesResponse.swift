//
//  TrendingMoviesResponse.swift
//  Repository
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation

struct TrendingMoviesResponse: Codable {
    
    let results: [Result]?
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
}

struct Result: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: Date?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
