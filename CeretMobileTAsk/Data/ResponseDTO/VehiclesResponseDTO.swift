//
//  VehiclesResponseDTO.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
struct VehiclesResponseDTO: Codable {
    let data: [VehiclesDTO]
}

// MARK: - Datum
struct VehiclesDTO: Codable,toDomain {
    let id: Int
    let hasSeller: Bool
    let year: String
    let additionalImages: [String]
    let brandID: Int
    let brand: String
    let brandImage: String
    let modelID: Int
    let model: String
    let modelImage: String
    let name: String
    let price, hiddenPrice: Int
    let stockAvailable: Bool
    let generation: String
    let sellingType: String?
    let isWishlisted, inCompareList: Bool
    let extraAttributes: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case hasSeller = "has_seller"
        case year
        case additionalImages = "additional_images"
        case brandID = "brand_id"
        case brand
        case brandImage = "brand_image"
        case modelID = "model_id"
        case model
        case modelImage = "model_image"
        case name, price
        case hiddenPrice = "hidden_price"
        case stockAvailable = "stock_available"
        case generation
        case sellingType = "selling_type"
        case isWishlisted = "is_wishlisted"
        case inCompareList = "in_compare_list"
        case extraAttributes = "extra_attributes"
    }
    func toDomain() -> Vechile {
        .init(name: name, price: price, extraAttributes: extraAttributes)
    }
}
