//
//  BrandModelsDTO.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation

struct BrandModelsDTO: Codable,toDomain {
    let data: [CarModelDTO]
    let ads: [Ad]
    
    func toDomain() -> BrandModels {
        return BrandModels(cars: data.map({$0.toDomain()}), ads: ads)
    }
}

struct CarModelDTO: Codable,toDomain {
    let id: Int
    let vehicleId: Int
    let name: String
    let image: String
    let leastDeposit: Double
    let leastInstallment: Int
    let identificationAttributeId: Int
    let identificationAttributeValueId: Int
    let attribute: String
    let attributeImage: String
    let attributeValue: String
    let price: Int
    let hiddenPrice: Int
    let parentBrand: String
    let parentBrandImage: String
    let attributesHintList: [AttributeHint]

    enum CodingKeys: String, CodingKey {
        case id, name, image, attribute, price
        case vehicleId = "vehicle_id"
        case leastDeposit = "least_deposit"
        case leastInstallment = "least_installment"
        case identificationAttributeId = "identification_attribute_id"
        case identificationAttributeValueId = "identification_attribute_value_id"
        case attributeImage = "attribute_image"
        case attributeValue = "attribute_value"
        case attributesHintList = "attributes_hint_list"
        case hiddenPrice = "hidden_price"
        case parentBrandImage = "parent_brand_image"
        case parentBrand = "parent_brand"
    }
    func toDomain() -> Car {
        return .init(id: id, vehicleId: vehicleId, name: name, image: image, ModelYear: attributeValue, startFrom: leastDeposit,identificationAttributeId: identificationAttributeId,identificationAttributeValueId: identificationAttributeValueId)
    }
}
