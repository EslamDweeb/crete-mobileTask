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
   
    
    var models: BehaviorRelay<[Car]> = .init(value: [])
    var ads: BehaviorRelay<[Ad]> = .init(value: [])
    
    var itemsCount:Int {
        isGrid.value == false ? (models.value.count + ads.value.count): models.value.count
    }
    
    var brandImageURL:String
    private var brandId:Int
    private var modelsRepo: ModelsRepo
    var currentPage = 1
    init(modelsRepo: ModelsRepo,brandId:Int,brandImageURL:String){
        self.modelsRepo = modelsRepo
        self.brandId = brandId
        self.brandImageURL = brandImageURL
    }
    
    func viewDidload(){
        Task {
            await getModels()
        }
    }
    
    private func getModels() async{
        isLoading.accept(true)
        do {
            let result = try await modelsRepo.getBrandModels(category: 3, brandId: brandId, currentPage: currentPage)
            models.accept(result.cars)
            ads.accept(result.ads)
        } catch {
            hasErrInTxt.onNext(error.localizedDescription)
        }
        isLoading.accept(false)
    }
    func configureAdCell(_ cell:AdCellViewModel,item:Int){
        let ad = ads.value[item]
        cell.configure(imageURL: ad.image)
    }
    func configureCarCell(_ cell: ModelCellViewModel,item:Int){
        let index = item >= 2 ? (item - 1) : item
        let item = models.value[index]
        cell.configure(imageURL: item.image, modelName: item.name, startFrom: "\(item.startFrom)", modelYear: item.ModelYear, isGrid: isGrid.value)
    }
}
