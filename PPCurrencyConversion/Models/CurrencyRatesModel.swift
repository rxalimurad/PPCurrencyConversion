//
//  CurrencyRatesModel.swift
//  PPCurrencyConversion
//
//  Created by murad on 28/10/2022.
//

import Foundation

struct CurrencyRatesModel: Codable {
    let disclaimer: String
    let license: String
    let timestamp: Int
    let base: String
    let rates: [String: Double]
}
