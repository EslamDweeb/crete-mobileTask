//
//  BaseClient.swift
//  CarsApp
//
//  Created by eslam dweeb on 25/01/2023.
//

import UIKit
import Alamofire
import Combine

enum NetworkError: Error, LocalizedError {
    case noData
    case other(String)
    case badRequest(String)
    case decodingFailed
    // Add more cases as needed

    var errorDescription: String? {
        switch self {
        case .noData:
            return NSLocalizedString("No data received from the server.", comment: "")
        case .other(let message):
            return message
        case .badRequest(let message):
            return message
        case .decodingFailed:
            return NSLocalizedString("Failed to decode the response data.", comment: "")
        // Add localized descriptions for other error cases if needed
        }
    }
}
protocol NetworkHandler {
    func performRequest(route: URLRequestConvertible,interceptor:RequestInterceptor?) async throws -> AFDataResponse<Data?>
    func uploadRequest(multiPart: MultipartFormData, route: URLRequestConvertible) async throws -> AFDataResponse<Data?>
}


protocol ResponseParser {
    func parseResponse<T: Decodable>(_ response: AFDataResponse<Data?>, with decoder: JSONDecoder) throws -> Result<T, NetworkError>
    
}
class DefaultResponseParser: ResponseParser {
    func parseResponse<T: Decodable>(_ response: AFDataResponse<Data?>, with decoder: JSONDecoder) throws -> Result<T, NetworkError> {
        print(response.response?.statusCode ?? "")
       
        guard let data = response.data else {
            print(response.response.debugDescription,"Body:\(String(data: response.request?.httpBody ?? Data(), encoding: .utf8) ?? "")")
            
            return .failure(.noData)
        }
        print(String(data: data, encoding: .utf8) ?? "")
        if let error = response.error {
            return .failure(.other(error.localizedDescription))
        }
        
        do {
            guard let statusCode = response.response?.statusCode else {
                return .failure(.other("Unknown response status code"))
            }
            
            if (200..<300).contains(statusCode) {
                if let optionalType = T.self as? OptionalDecodable.Type, statusCode == 204 {
                    return .success( optionalType.init(nil) as! T)
                } else {
                    let dataJson = try decoder.decode(T.self, from: data)
                    return .success(dataJson)
                }
            }  else {

                return .failure(.other("Unknown server error\(statusCode) \("Response")\(response.response.debugDescription) \(String(data: response.data ?? Data(), encoding: .utf8) ?? "")"))
            }
        } catch {
            print(error)
            return .failure(.decodingFailed)
        }
    }
}

protocol OptionalDecodable {
    init(_ value: Any?)
}

extension Optional: OptionalDecodable {
    init(_ value: Any?) {
        if let value = value as? Wrapped {
            self = .some(value)
        } else {
            self = .none
        }
    }
}



class NetworkManager: NetworkHandler {
    func performRequest(route: Alamofire.URLRequestConvertible, interceptor:RequestInterceptor?) async throws -> Alamofire.AFDataResponse<Data?> {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(route,interceptor: interceptor).response { response in
                continuation.resume(returning: response)
            }
        }
    }
    
    func uploadRequest(multiPart: MultipartFormData, route: URLRequestConvertible) async throws -> AFDataResponse<Data?> {
        return try await withCheckedThrowingContinuation { continuation in
            AF.upload(multipartFormData: multiPart, with: route).response { response in
                continuation.resume(returning: response)
            }
        }
    }
}

class BaseClient {
    private let networkHandler: NetworkHandler
    private let responseParser: ResponseParser
    
    init(networkHandler: NetworkHandler = NetworkManager(), responseParser: ResponseParser = DefaultResponseParser()) {
        self.networkHandler = networkHandler
        self.responseParser = responseParser
    }
     func performRequest<T: Decodable>(route: URLRequestConvertible, decoder: JSONDecoder = JSONDecoder()) async throws -> Result<T, NetworkError> {
        do {
            let response = try await networkHandler.performRequest(route: route, interceptor: nil)
            return try responseParser.parseResponse(response, with: decoder)
        } catch {
            return .failure(.other(error.localizedDescription))
        }
    }
    
     func uploadRequest<T: Decodable>(multiPart: MultipartFormData, route: URLRequestConvertible, decoder: JSONDecoder = JSONDecoder()) async throws -> Result<T, NetworkError> {
        do {
            let response = try await networkHandler.uploadRequest(multiPart: multiPart, route: route)
            return try responseParser.parseResponse(response, with: decoder)
        } catch {
            return .failure(.other(error.localizedDescription))
        }
    }
}



