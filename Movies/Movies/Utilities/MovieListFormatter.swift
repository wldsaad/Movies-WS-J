//
//  MovieListFormatter.swift
//  Movies
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

struct MovieListFormatter {
    
    func callAsFunction(_ list: [String?]?) -> String {
        list?.compactMap { $0 }.joined(separator: ", ") ?? ""
    }
}
