//
//  UserDefaults.swift
//  PPCurrencyConversion
//
//  Created by murad on 28/10/2022.
//

import Foundation

enum Preference {
    static var backUpDate: Double? {
        get {
            UserDefaults.standard.object(forKey: Constants.UserDefaultKeys.backUpDate) as? Double
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultKeys.backUpDate)
        }
    }
    
    static var rateList: CurrencyRatesModel? {
        get {
            if let data = UserDefaults.standard.data(forKey: Constants.UserDefaultKeys.rateList) {
                let decoder = JSONDecoder()
                return try? decoder.decode(CurrencyRatesModel.self, from: data)
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(newValue)
            UserDefaults.standard.set(data, forKey: Constants.UserDefaultKeys.rateList)
        }
    }
    static var countryList: CountriesListModel? {
        get {
            if let data = UserDefaults.standard.data(forKey: Constants.UserDefaultKeys.countryList) {
                let decoder = JSONDecoder()
                return try? decoder.decode(CountriesListModel.self, from: data)
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(newValue)
            UserDefaults.standard.set(data, forKey: Constants.UserDefaultKeys.countryList)
        }
    }

    
    
}
