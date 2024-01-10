//
//  CachedImage.swift
//  Movies
//
//  Created by Waleed Saad on 09/01/2024.
//

import Foundation
import SwiftData

@Model
final class CachedImage: Identifiable {
    
    @Attribute(.unique)
    let url: String
    @Attribute(.externalStorage)
    let imageData: Data
    
    init(url: String, imageData: Data) {
        self.imageData = imageData
        self.url = url
    }
}
