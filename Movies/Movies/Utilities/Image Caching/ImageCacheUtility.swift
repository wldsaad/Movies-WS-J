//
//  ImageCacheUtility.swift
//  Movies
//
//  Created by Waleed Saad on 09/01/2024.
//

import SwiftUI
import SwiftData

@MainActor
struct ImageCacheUtility {
    
    static subscript(url: String) -> Image? {
        get {
            do {
                let predicate = #Predicate<CachedImage> { $0.url == url }
                guard let cachedImage: CachedImage = try LocalDataContainer.shared.getCached(predicate: predicate).first,
                      let uiImage = UIImage(data: cachedImage.imageData) else { return nil }
                
                return .init(uiImage: uiImage)
            } catch { return nil }
        }
        
        set {
            do {
                guard !url.isEmpty,
                      let imageData = ImageRenderer(content: newValue).uiImage?.jpegData(compressionQuality: 1) else { return }
                
                try LocalDataContainer.shared.insert(CachedImage(url: url, imageData: imageData))
            } catch {}
        }
    }
}
