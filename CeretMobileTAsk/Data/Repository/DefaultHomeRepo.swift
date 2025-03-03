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
    func getLeadsStatus() async throws -> [LeadsStatus] {
        let result: Result<BaseDTO<[LeadsStatusDTO]>, NetworkError>
        do {
            result = try await client.getLeadsStatus()
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
