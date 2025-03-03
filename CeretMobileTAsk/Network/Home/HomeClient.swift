//
//  AuthClient.swift
//  LABYFI
//
//  Created by eslam dweeb on 24/07/2023.
//

import Foundation

import Alamofire


class HomeClient:BaseClient {
    
     func getBrands<T:Decodable>(categoryId:Int) async throws -> Result<T, NetworkError>  {
         return try await performRequest(route: HomeRouter.getBrand(category: categoryId))
    }
   
}
