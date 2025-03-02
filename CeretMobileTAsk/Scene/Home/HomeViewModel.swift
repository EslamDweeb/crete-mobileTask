//
//  HomeViewModel.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 02/03/2025.
//

import Foundation

import RxSwift
import RxCocoa

class HomeViewModel:ViewModel{
    var hasErrInTxt: PublishSubject<String> = .init()
    var isLoading: BehaviorRelay<Bool>  = .init(value: false)
    
    
}
