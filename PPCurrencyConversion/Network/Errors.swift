//
//  Errors.swift
//  PPCurrencyConversion
//
//  Created by murad on 28/10/2022.
//

import Foundation
enum NetworkRequestError: Error {
    case unknown
    case requestError
    case notConnected
    case serverError(error: String)
}
