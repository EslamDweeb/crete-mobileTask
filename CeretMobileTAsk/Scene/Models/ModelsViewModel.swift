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
    
    init(brandId:Int,brandImageURL:String){
        self.brandId = brandId
        self.brandImageURL = brandImageURL
    }
    
    func viewDidload(){
        brandImageURLSubject.onNext(brandImageURL)
    }
}
