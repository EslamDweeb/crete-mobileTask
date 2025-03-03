//
//  ModelsRouter.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
import Alamofire

enum ModelsRouter:TargetType {
    case getBrandModels(category:Int,brandId:Int,currentPage:Int)
   
    
        
    var queryies: [URLQueryItem]? {
        switch self {
        case.getBrandModels(let categoryId,let brandId,let currentPage):
            return [
                .init(name: "category", value: "\(categoryId)"),
                .init(name: "brand", value: "\(brandId)"),
                .init(name: "page", value: "\(currentPage)")
            ]
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
        case .getBrandModels:
            return "models"
       
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
