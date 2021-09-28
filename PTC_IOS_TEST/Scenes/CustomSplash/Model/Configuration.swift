//
//  Configuration.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/16/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation

// MARK: - ConfigurationResponse
struct ConfigurationResponse: Codable {
    let success: Bool?
    let session: SessionData?
    let metadata: Metadata?
}

// MARK: - Metadata
struct Metadata: Codable {
    let currency: Currency?
    let languages: [Language]?
    let support: Support?
}

// MARK: - Currency
struct Currency: Codable {
    let iso, currencySymbol: String?
    let position, decimals: Int?
    let thousandsSep, decimalsSep: String?

    enum CodingKeys: String, CodingKey {
        case iso
        case currencySymbol = "currency_symbol"
        case position, decimals
        case thousandsSep = "thousands_sep"
        case decimalsSep = "decimals_sep"
    }
}

// MARK: - Language
struct Language: Codable {
    let code, name: String?
    let languageDefault: Bool?

    enum CodingKeys: String, CodingKey {
        case code, name
        case languageDefault = "default"
    }
}

// MARK: - Support
struct Support: Codable {
    let phoneNumber: String?
    let callToOrderEnabled: Bool?
    let csEmail: String?

    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case callToOrderEnabled = "call_to_order_enabled"
        case csEmail = "cs_email"
    }
}

// MARK: - SessionData
struct SessionData: Codable {
    let id: String?
    let expire: String?
    let yiiCSRFToken: String?

    enum CodingKeys: String, CodingKey {
        case id, expire
        case yiiCSRFToken = "YII_CSRF_TOKEN"
    }
}
