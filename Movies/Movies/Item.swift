//
//  Item.swift
//  Movies
//
//  Created by Waleed Saad on 04/01/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
