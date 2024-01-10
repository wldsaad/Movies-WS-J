//
//  LocalDataContainer.swift
//  Movies
//
//  Created by Waleed Saad on 08/01/2024.
//

import Foundation
import SwiftData
import SwiftDataRepository

@MainActor
final class LocalDataContainer {
    
    // MARK: - Properties
    
    static let shared = LocalDataContainer()
        
    // MARK: - Init
    
    private init() {
        SwiftDataRepository.shared.register(models: [
            Movie.self,
            Genre.self,
            MovieDetails.self,
            MoviesPagination.self,
            CachedImage.self
        ])
    }
    
    // MARK: - APIs
    
    func getCached<T: PersistentModel>(predicate: Predicate<T>? = nil, sortBy sortDescriptors: [SortDescriptor<T>] = []) throws -> [T] {
        try SwiftDataRepository.shared.getCached(predicate: predicate, sortBy: sortDescriptors)
    }
    
    func insert<T: PersistentModel>(_ model: T) throws {
        try SwiftDataRepository.shared.insert(model)
    }
    
    func insert<T: PersistentModel>(_ models: [T]) throws {
        try SwiftDataRepository.shared.insert(models)
    }
    
    func deleteAll<T: PersistentModel>(_ model: T.Type) throws {
        try SwiftDataRepository.shared.deleteAll(model)
    }
}
