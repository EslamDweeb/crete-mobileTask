//
//  ModelGenerationsViewModel.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import Foundation
import RxSwift
import RxCocoa

class ModelGenerationsViewModel:ViewModel{
    
    var hasErrInTxt: PublishSubject<String> = .init()
    var isLoading: BehaviorRelay<Bool> = .init(value: false)
    var vechiles: BehaviorRelay<[Vechile]> = .init(value: [])
    private var model:Car
    private var modelGenerationsRepo:ModelGenerationRepo
    private(set) var brandImageURL:String
    
    var modelName:String{
        model.name
    }
    var modelImageURL:String{
        model.image
    }
    var modelYear:String{
        model.ModelYear
    }
    
    init(brandImageURL:String,modelGenerationsRepo: ModelGenerationRepo,model: Car) {
        self.model = model
        self.modelGenerationsRepo = modelGenerationsRepo
        self.brandImageURL = brandImageURL
    }
    
    func viewDidload(){
        Task{
            await getVechiles()
        }
    }
    
    func getVechiles() async {
        isLoading.accept(true)
        do {
            let result = try await modelGenerationsRepo.getVechiles(category: 3, modelId: model.id, identificationAttributeId: model.identificationAttributeId, identificationAttributeValueId: model.identificationAttributeValueId)
            vechiles.accept(result)
        } catch {
            hasErrInTxt.onNext(error.localizedDescription)
        }
        isLoading.accept(false)
    }
}
