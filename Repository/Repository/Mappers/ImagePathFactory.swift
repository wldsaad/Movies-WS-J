//
//  ImagePathFactory.swift
//  Repository
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

struct ImagePathFactory {
    
    enum ImagePath {
        case thumbnail, poster
        
        var size: String {
            switch self {
            case .thumbnail: "w300"
            case .poster: "original"
            }
        }
    }
    
    func imagePath(_ path: String?, imagePath: ImagePath) -> String {
        guard let path, !path.isEmpty else { return "" }
        
        let base = "https://image.tmdb.org/t/p/"
        return #"\#(base)\#(imagePath.size)\#(path)"#
    }
}
