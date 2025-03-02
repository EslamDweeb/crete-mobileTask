//
//  AuthRouter.swift
//  LABYFI
//
//  Created by eslam dweeb on 24/07/2023.
//

import Foundation
import Alamofire

enum AuthRouter:TargetType {
    
    case login(email:String,password:String)
    case logout(fcm:String)
    
        
    var queryies: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return Constants.baseUrl.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .logout:
            return "/user/logout"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .login(let email,let password):
            var dic:Parameters = [
                "email":email,
                "password":password,
            ]
           
            return dic
        case .logout(let fcm):
            return ["firebase_token":fcm]
        }
    }
    
    var DataDic: Codable?{
        switch self {
        default:
            return nil
        }
    }
    
    var headers: [String : String]?{
        switch self {
        default:
            return [
                Constants.acceptType.rawValue: Constants.json.rawValue,
                Constants.contentType.rawValue:Constants.json.rawValue
            ]
        }
    }
    var multipart: Alamofire.MultipartFormData?{
        nil
    }
}
