//
//  APIRequest.swift
//  Repository
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation

public protocol APIRequest {

    var baseURL: URL { get }
    var path: String { get }
    var method: APIRequestMethod { get }
    var headers: [String: String]? { get }
}

public enum APIRequestMethod: String {

    case get, post, put, patch, delete
}

public extension APIRequest {
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: baseURL.appending(path: path))
        request.httpMethod = method.rawValue.uppercased()
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}
