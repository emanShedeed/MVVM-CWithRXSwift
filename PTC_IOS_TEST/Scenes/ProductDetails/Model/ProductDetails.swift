//
//  ProductDetails.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/18/21.
//  Copyright © 2021 Jumia. All rights reserved.
//


import Foundation

// MARK: - ProductDetails
struct ProductDetails: Codable {
    let success: Bool?
    let metadata: ProductMetadata?
}

// MARK: - Metadata
struct ProductMetadata: Codable {
    let sku, name: String?
    let maxSavingPercentage, price, specialPrice: Int?
    let brand: String?
    let rating: Rating?
    let imageList: [String]?
    let summary: Summary?
    let sellerEntity: SellerEntity?

    enum CodingKeys: String, CodingKey {
        case sku, name
        case maxSavingPercentage = "max_saving_percentage"
        case price
        case specialPrice = "special_price"
        case brand, rating
        case imageList = "image_list"
        case summary
        case sellerEntity = "seller_entity"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let average, ratingsTotal: Int?

    enum CodingKeys: String, CodingKey {
        case average
        case ratingsTotal = "ratings_total"
    }
}

// MARK: - SellerEntity
struct SellerEntity: Codable {
    let id: Int?
    let name, deliveryTime: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case deliveryTime = "delivery_time"
    }
}

// MARK: - Summary
struct Summary: Codable {
    let shortDescription, summaryDescription: String?

    enum CodingKeys: String, CodingKey {
        case shortDescription = "short_description"
        case summaryDescription = "description"
    }
}
