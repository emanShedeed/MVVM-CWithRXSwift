//
//  Product.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//


import Foundation

// MARK: - Products
struct Products: Codable {
    let success: Bool?
    let metadata: ProductData?
}

// MARK: - Metadata
struct ProductData: Codable {
    let sort: String?
    let totalProducts: Int?
    let title: String?
    let results: [ItemResult]?

    enum CodingKeys: String, CodingKey {
        case sort
        case totalProducts = "total_products"
        case title, results
    }
}

// MARK: - Result
struct ItemResult: Codable {
    let sku, name: String?
    let brand: String?
    let maxSavingPercentage, price, specialPrice: Int?
    let image: String?
    let ratingAverage: Int?

    enum CodingKeys: String, CodingKey {
        case sku, name, brand
        case maxSavingPercentage = "max_saving_percentage"
        case price
        case specialPrice = "special_price"
        case image
        case ratingAverage = "rating_average"
    }
}


