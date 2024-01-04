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
