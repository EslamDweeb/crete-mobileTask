//
//  AuthRouter.swift
//  LABYFI
//
//  Created by eslam dweeb on 24/07/2023.
//

import Foundation
import Alamofire

enum HomeRouter:TargetType {
    case getBrand(category:Int)
   
    
        
    var queryies: [URLQueryItem]? {
        switch self {
        case.getBrand(let id):
            return [.init(name: "category", value: "\(id)")]
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
        case .getBrand:
            return "brands"
       
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: Parameters?{
       return nil
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
