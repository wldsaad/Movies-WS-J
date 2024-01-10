//
//  ImagePathFactory.swift
//  DataTransferObjects
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

public struct ImagePathFactory {
    
    public enum ImagePath {
        case thumbnail, poster
        
        var size: String {
            switch self {
            case .thumbnail: "w300"
            case .poster: "original"
            }
        }
    }
    
    public func imagePath(_ path: String?, imagePath: ImagePath) -> String {
        guard let path, !path.isEmpty else { return "" }
        
        let base = "https://image.tmdb.org/t/p/"
        return #"\#(base)\#(imagePath.size)\#(path)"#
    }
}
