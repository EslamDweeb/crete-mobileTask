//
//  ModelsViewModel.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
import RxSwift
import RxCocoa

class ModelsViewModel:ViewModel {
    var hasErrInTxt: PublishSubject<String> = .init()
    var isLoading: BehaviorRelay<Bool> = .init(value: false)
    
    var isGrid:BehaviorRelay<Bool> = .init(value: false)
    var brandImageURLSubject:PublishSubject<String> = .init()
    
    private var brandImageURL:String
    private var brandId:Int
    private var modelsRepo: ModelsRepo
    var currentPage = 1
    init(modelsRepo: ModelsRepo,brandId:Int,brandImageURL:String){
        self.modelsRepo = modelsRepo
        self.brandId = brandId
        self.brandImageURL = brandImageURL
    }
    
    func viewDidload(){
        brandImageURLSubject.onNext(brandImageURL)
        Task {
            await getModels()
        }
    }
    
    private func getModels() async{
        isLoading.accept(true)
        do {
            let result = try await modelsRepo.getBrandModels(category: 3, brandId: brandId, currentPage: currentPage)
//            brands.append(contentsOf: result)
//            
//            // Update filteredBrands with the initial data
//            filteredBrands.accept(brands)
        } catch {
            hasErrInTxt.onNext(error.localizedDescription)
        }
        isLoading.accept(false)
    }
}
