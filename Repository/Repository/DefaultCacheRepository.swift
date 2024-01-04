//
//  DefaultCacheRepository.swift
//  Repository
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation

public struct DefaultCacheRepository<Local: LocalDataSource, Remote: RemoteDataSource>: Repository {

    // MARK: - Types
    
    public typealias LocalRepository = Local
    public typealias RemoteRepository = Remote

    // MARK: - Properties
    
    private var localRepository: LocalRepository
    private var remoteRepository: RemoteRepository

    // MARK: - Init
    
    public init(localRepository: LocalRepository, remoteRepository: RemoteRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }

    // MARK: - APIs
    
    mutating public func getData<Value: Codable>(api: APIRequest, cachePolicy: CachePolicy) async throws -> Value {
        switch cachePolicy {
        case .always:
            do {
                return try await getLocalData(api: api)
            } catch {
                let response: Value = try await getRemoteData(api: api)
                await saveData(api: api, value: response)
                return response
            }
        case .never:
            return try await getRemoteData(api: api)
        case .remoteFirst:
            do {
                let response: Value = try await getRemoteData(api: api)
                await saveData(api: api, value: response)
                return response
            } catch {
                return try await getLocalData(api: api)
            }
        }
    }

    // MARK: - Methods
    
    mutating private func getLocalData<Value: Codable>(api: APIRequest) async throws -> Value {
        try await localRepository.getData(api: api)
    }

    mutating private func getRemoteData<Value: Codable>(api: APIRequest) async throws -> Value {
        try await remoteRepository.getData(api: api)
    }

    mutating private func saveData<Value: Codable>(api: APIRequest, value: Value) async {
        guard case .get = api.method else { return }

        let key = api.baseURL.absoluteString + api.path
        await localRepository.saveValue(key: key, value: value)
    }
}
