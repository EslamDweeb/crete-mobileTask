//
//  DefaultHomeRepo.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
class DefaultHomeRepo:HomeRepo {
    private var client:HomeClient
    init(client:HomeClient) {
        self.client = client
    }
    func  getBrands(categoryId:Int) async throws -> [Brand] {
        let result: Result<BrandResponse, NetworkError>
        do {
            result = try await client.getBrands(categoryId: categoryId)
        } catch {
            throw error
        }
        switch result {
        case .success(let success):
            return success.data
        case .failure(let failure):
            print(failure)
            throw failure
        }
    }
   
}
