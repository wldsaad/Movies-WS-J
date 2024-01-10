//
//  SpokenLanguagesTitleGenerator.swift
//  Movies
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation
import Domain

struct SpokenLanguagesTitleGenerator {
    
    func callAsFunction(_ languages: [SpokenLanguage]?) -> String {
        MovieListFormatter()(languages?.map { $0.name })
    }
}
