//
//  APIClient.swift
//  PPCurrencyConversion
//
//  Created by murad on 28/10/2022.
//

import Combine
import Foundation
protocol APIClientType {
    func request<T:Decodable>(router: URLRequestConvertibleType) -> AnyPublisher<T,NetworkRequestError>
}

final class APIClient: APIClientType {
    
    func request<T>(router: URLRequestConvertibleType) -> AnyPublisher<T, NetworkRequestError> where T : Decodable {
        let urlRequest = (try? router.urlRequest())!

        return URLSession.shared.dataTaskPublisher(for : urlRequest ).map { a in a.data }.decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? NetworkRequestError {
                    return error
                } else {
                    return NetworkRequestError.serverError(error: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
}
