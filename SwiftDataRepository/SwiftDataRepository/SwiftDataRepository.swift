//
//  SwiftDataRepository.swift
//  SwiftDataRepository
//
//  Created by Waleed Saad on 08/01/2024.
//

import Foundation
import SwiftData

@MainActor
public final class SwiftDataRepository {
    
    // MARK: - Properties
    
    static public let shared = SwiftDataRepository()
    
    private var modelContext: ModelContext!
    
    // MARK: - Init
    
    private init() {}
    
    public func register(models: [any PersistentModel.Type]) {
        let modelContainer: ModelContainer = {
            let schema = Schema(models.map { $0.self })
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        modelContext = modelContainer.mainContext
    }
    
    // MARK: - APIs
    
    public func getCached<T: PersistentModel>(predicate: Predicate<T>? = nil, sortBy sortDescriptors: [SortDescriptor<T>] = []) throws -> [T] {
        do {
            let descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortDescriptors)
            return try modelContext.fetch(descriptor)
        } catch {
            throw error
        }
    }
    
    public func insert<T: PersistentModel>(_ model: T) throws {
        modelContext.insert(model)
    }
    
    public func replaceAll<T: PersistentModel>(_ models: [T]) throws {
        let current: [T] = try getCached()
        current.forEach { modelContext.delete($0) }
        try modelContext.save()
        models.forEach { modelContext.insert($0) }
        try modelContext.save()
    }
}
