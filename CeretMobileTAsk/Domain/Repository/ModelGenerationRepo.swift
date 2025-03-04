//
//  ModelGenerationRepo.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
protocol ModelGenerationRepo{
    
    func getVechiles(category:Int,modelId:Int,identificationAttributeId:Int,identificationAttributeValueId:Int) async throws -> [Vehicle]
    
}
