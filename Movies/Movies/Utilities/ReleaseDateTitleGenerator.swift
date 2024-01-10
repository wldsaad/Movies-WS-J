//
//  ReleaseDateTitleGenerator.swift
//  Movies
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

struct ReleaseDateTitleGenerator {
    
    func callAsFunction(_ releaseDate: Date?) -> String {
        let month = releaseDate?.formatted(Date.FormatStyle().month(.abbreviated))
        let year = releaseDate?.formatted(Date.FormatStyle().year())
        return [month, year].compactMap { $0 }.joined(separator: " ")
    }
}
