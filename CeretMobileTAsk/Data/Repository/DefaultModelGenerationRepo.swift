//
//  DefaultModelGenerationRepo.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
class DefaultModelGenerationRepo:ModelGenerationRepo {
   
    private var client:ModelGenerationsClient
    
    init(client:ModelGenerationsClient) {
        self.client = client
    }
   
    func getVechiles(category: Int, modelId: Int, identificationAttributeId: Int, identificationAttributeValueId: Int) async throws -> [Vechile] {
        let result: Result<VehiclesResponseDTO, NetworkError>
        do {
            result = try await client.getVechiles(category: category, modelId: modelId, identificationAttributeId: identificationAttributeId, identificationAttributeValueId: identificationAttributeValueId)
        } catch {
            throw error
        }
        switch result {
        case .success(let success):
            return success.data.map({$0.toDomain()})
        case .failure(let failure):
            print(failure)
            throw failure
        }
    }
}
