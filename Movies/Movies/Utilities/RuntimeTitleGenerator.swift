//
//  RuntimeTitleGenerator.swift
//  Movies
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

struct RuntimeTitleGenerator {
    
    func callAsFunction(_ runtime: Double?) -> String {
        guard let runtime = runtime else { return "" }

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: runtime * 60) ?? ""
    }
}
