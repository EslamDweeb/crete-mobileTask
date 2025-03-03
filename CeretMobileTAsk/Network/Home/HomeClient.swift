//
//  AuthClient.swift
//  LABYFI
//
//  Created by eslam dweeb on 24/07/2023.
//

import Foundation

import Alamofire


class AuthClient:BaseClient {
    
     func login<T:Decodable>(email:String,password:String) async throws -> Result<T, NetworkError>  {
        return try await performRequest(route: AuthRouter.login(email: email, password: password))
    }
    func logout<T:Decodable>(fcmToken:String) async throws -> Result<T, NetworkError>  {
       return try await performRequest(route: AuthRouter.logout(fcm: fcmToken))
   }
}
