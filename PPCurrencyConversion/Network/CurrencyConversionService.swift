//
//  CurrencyConversionService.swift
//  PPCurrencyConversion
//
//  Created by murad on 28/10/2022.
//

import Foundation
import Combine

protocol CurrencyConversionServiceType {
    func getCurrencyList()->AnyPublisher<[String: String], NetworkRequestError>
    func getLatestRates()->AnyPublisher<CurrencyRatesModel, NetworkRequestError>
}

final class CurrencyConversionService: CurrencyConversionServiceType {
    private let apiClient: APIClientType
    
    init(apiClient: APIClientType = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getCurrencyList() -> AnyPublisher<[String: String], NetworkRequestError> {
        let req = Endpoint(sericeName: .currencyList,
                           method: .get,
                           queryItems: [Constants.Network.apiKeyParamName: Constants.Network.apiKeyParamValue] )
        return apiClient.request(router: req).eraseToAnyPublisher()
    }
    
    func getLatestRates() -> AnyPublisher<CurrencyRatesModel, NetworkRequestError> {
        let req = Endpoint(sericeName: .lastestRateList,
                           method: .get,
                           queryItems: [Constants.Network.apiKeyParamName: Constants.Network.apiKeyParamValue])
        return apiClient.request(router: req).eraseToAnyPublisher()
    }
}
