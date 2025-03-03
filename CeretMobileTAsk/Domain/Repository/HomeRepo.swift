//
//  HomeRepo.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
protocol HomeRepo{
    func getBrands(categoryId:Int) async throws -> [Brand]
}
