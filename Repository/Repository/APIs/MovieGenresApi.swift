//
//  MovieGenresApi.swift
//  Repository
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

struct MovieGenresApi: APIRequest {
    
    var path = #"/genre/movie/list"#
    
    var method: APIRequestMethod = .get
}
