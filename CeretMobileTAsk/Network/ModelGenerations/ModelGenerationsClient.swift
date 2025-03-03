//
//  ModelGenerationsClient.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
import Alamofire


class ModelGenerationsClient:BaseClient {
    
     func getVechiles<T:Decodable>(category:Int,modelId:Int,identificationAttributeId:Int,identificationAttributeValueId:Int) async throws -> Result<T, NetworkError>  {
         return try await performRequest(route: ModelGenerationsRouter.getVechiles(category: category, modelId: modelId, identificationAttributeId: identificationAttributeId, identificationAttributeValueId: identificationAttributeValueId))
    }
   
}
