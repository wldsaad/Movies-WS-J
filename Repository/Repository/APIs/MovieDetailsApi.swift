//
//  MovieDetailsApi.swift
//  Repository
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

struct MovieDetailsApi: APIRequest {
    
    let path: String
    
    let method: APIRequestMethod = .get
        
    init(id: Int) {
        self.path = #"/movie/\#(id)"#
    }
}
