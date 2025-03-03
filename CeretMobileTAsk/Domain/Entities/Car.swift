//
//  Car.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation

struct BrandModels{
    let cars:[Car]
    let ads:[Ad]
}
struct Car {
    let id: Int
    let vehicleId: Int
    let name: String
    let image: String
    let ModelYear: String
    let startFrom: Int
    let identificationAttributeId: Int
    let identificationAttributeValueId: Int
}
