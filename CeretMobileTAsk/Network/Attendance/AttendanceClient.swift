//
//  AttendanceClient.swift
//  LABYFI
//
//  Created by eslam dweeb on 21/08/2023.
//

import Foundation
import Alamofire


class AttendanceClient:BaseClient {
    func getAttendanceForCurrentMonth<T:Decodable>() async throws -> Result<T, NetworkError>{
        return try await performRequest(route: AttendanceRouter.getAttendanceForCurrentMonth)
    }
    func checkInForAttendance<T:Decodable>(lat:String,long:String) async throws -> Result<T, NetworkError>{
        return try await performRequest(route: AttendanceRouter.checkIn(lat: lat, long: long))
    }
    func checkOutForAttendance<T:Decodable>(lat:String,long:String) async throws -> Result<T, NetworkError>{
        return try await performRequest(route: AttendanceRouter.checkOut(lat: lat, long: long))
    }
    func getAttedanceDetails<T:Decodable>() async throws -> Result<T, NetworkError>{
        return try await performRequest(route: AttendanceRouter.getAttedanceDetails)
    }
    func getAdminAttendanceInfo<T:Decodable>(date:String) async throws -> Result<T, NetworkError>{
        return try await performRequest(route: AttendanceRouter.adminAttendanceForCurrentDay(date: date))
    }
}
