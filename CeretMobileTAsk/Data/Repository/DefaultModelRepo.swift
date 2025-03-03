//
//  DefaultModelRepo.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
class DefaultModelRepo:ModelsRepo {
    
    
    private var client:ModelsClient
    
    init(client:ModelsClient) {
        self.client = client
    }
    func getBrandModels(category: Int, brandId: Int, currentPage: Int) async throws -> BrandModels {
        let result: Result<BrandModelsDTO, NetworkError>
        do {
            result = try await client.getBrandModels(category: category, brandId: brandId, currentPage: currentPage)
        } catch {
            throw error
        }
        switch result {
        case .success(let success):
            return success.toDomain()
        case .failure(let failure):
            print(failure)
            throw failure
        }
    }
}
