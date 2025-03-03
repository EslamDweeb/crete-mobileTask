//
//  BrandResponse.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
struct BrandResponse: Codable {
    let data: [Brand]
}

struct Brand: Codable {
    let id: Int
    let name: String
    let image: String
}
