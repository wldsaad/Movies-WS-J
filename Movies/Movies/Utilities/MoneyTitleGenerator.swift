//
//  MoneyTitleGenerator.swift
//  Movies
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

struct MoneyTitleGenerator {
    
    private let numberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "USD"
        numberFormatter.currencySymbol = "$"
        return numberFormatter
    }()
    
    func callAsFunction(_ money: Double?) -> String {
        numberFormatter.string(for: money) ?? ""
    }
}
