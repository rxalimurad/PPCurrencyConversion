//
//  Constants.swift
//  PPCurrencyConversion
//
//  Created by murad on 28/10/2022.
//

import Foundation

enum Constants {
    
    enum Global {
        static let cacheTimeInMinutes: Double = 0.1
    }
    enum Network {
        static let apiKeyParamName = "app_id"
        static let apiKeyParamValue = "97562bf6b57642a5a596d2c9d6e31244"
    }
    enum CellIdentifier {
        static let toAmountCell = "ToAmountCell"
    }
    
    enum UserDefaultKeys {
        static let backUpDate = "backUpDate"
        static let rateList = "rateList"
        static let countryList = "countryList"
    }
}
