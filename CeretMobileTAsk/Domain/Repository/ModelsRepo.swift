//
//  ModelsRepo.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
protocol ModelsRepo{
    func getBrandModels(category:Int,brandId:Int,currentPage:Int) async throws -> BrandModels
}
