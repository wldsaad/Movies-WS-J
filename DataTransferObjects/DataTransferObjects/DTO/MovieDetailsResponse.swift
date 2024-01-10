//
//  MovieDetailsResponse.swift
//  DataTransferObjects
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

public struct MovieDetailsResponse: Codable {
    
    public let id: Int?
    public let adult: Bool?
    public let backdropPath: String?
    public let budget: Double?
    public let revenue: Double?
    public let genres: [MovieGenre]?
    public let homepage: String?
    public let originalTitle: String?
    public let title: String?
    public let overview: String?
    public let posterPath: String?
    public let releaseDate: Date?
    public let runtime: Double?
    public let spokenLanguages: [SpokenLanguage]?
    public let status: String?
    public let video: Bool?
    public let popularity: Double?
    public let voteAverage: Double?
    public let voteCount: Int?
}

public struct SpokenLanguage: Codable {
    
    public let englishName: String?
    public let name: String?
}
