//
//  TrendingMoviesResponse.swift
//  DataTransferObjects
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

public struct TrendingMoviesResponse: Codable {
    
    public let results: [Result]?
    public let page: Int?
    public let totalPages: Int?
    public let totalResults: Int?
}

public struct Result: Codable {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIds: [Int]?
    public let id: Int?
    public let originalTitle: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let releaseDate: Date?
    public let title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
}
