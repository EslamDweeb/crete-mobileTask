//
//  ModelGenerationsRouter.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
import Alamofire

enum ModelGenerationsRouter:TargetType {
    case getVechiles(category:Int,modelId:Int,identificationAttributeId:Int,identificationAttributeValueId:Int)
    
        
    var queryies: [URLQueryItem]? {
        switch self {
        case .getVechiles(let categoryId,let modelId,let identificationAttributeId,let identificationAttributeValueId):
            return [
                .init(name: "category", value: "\(categoryId)"),
                .init(name: "model", value: "\(modelId)"),
                .init(name: "identification_attribute_id", value: "\(identificationAttributeId)"),
                .init(name: "identification_attribute_value_id", value: "\(identificationAttributeValueId)")
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
        case .getVechiles:
            return "vehicles"
       
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
