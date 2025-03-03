//
//  ModelsClient.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
import Alamofire


class ModelsClient:BaseClient {
    
     func getBrandModels<T:Decodable>(category:Int,brandId:Int,currentPage:Int) async throws -> Result<T, NetworkError>  {
         return try await performRequest(route: ModelsRouter.getBrandModels(category: category, brandId: brandId, currentPage: currentPage))
    }
   
}
