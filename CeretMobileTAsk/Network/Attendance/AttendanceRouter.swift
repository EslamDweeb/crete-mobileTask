//
//  AttendanceRouter.swift
//  LABYFI
//
//  Created by eslam dweeb on 21/08/2023.
//

import Foundation
import Alamofire

enum AttendanceRouter:TargetType {
    case getAttendanceForCurrentMonth
    case checkIn(lat:String,long:String)
    case checkOut(lat:String,long:String)
    case getAttedanceDetails
    case adminAttendanceForCurrentDay(date:String)
    
    
  
    var accessToken:String{
        let helper = KeyChainHelper.standard
        return helper.read(service: KeyChainServiceName.userData.rawValue, account: Constants.account.rawValue, type: User.self)!.token
    }
    var baseURL: String {
        switch self {
        default:
            return Constants.baseUrl.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getAttendanceForCurrentMonth:
            return "/agent-attendance/agent-current-month-info"
        case .checkIn:
            return "/agent-attendance/check-in"
        case .checkOut :
            return "/agent-attendance/check-out"
        case .getAttedanceDetails:
            return "/agent-attendance/agent-attendance-details"
        case .adminAttendanceForCurrentDay:
            return "/agent-attendance/all-attendance"
        }
    }
    var queryies: [URLQueryItem]? {
        switch self {
        case .adminAttendanceForCurrentDay(let date):
            return [.init(name: "date", value: date)]
        default:
            return nil
        }
    }
    var method: HTTPMethod {
        switch self {
        case .checkIn,.checkOut:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .checkIn(let lat, let long),.checkOut(let lat, let long):
            return [
                "latitude":lat,
                "longitude":long
            ]
        default:
            return nil
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
                Constants.authentication.rawValue :"\(Constants.token.rawValue) \(accessToken)",
                Constants.acceptType.rawValue: Constants.json.rawValue,
                Constants.contentType.rawValue:Constants.json.rawValue
            ]
        }
    }
    var multipart:MultipartFormData?{
        switch self {
        default:
            return nil
        }
    }
}
