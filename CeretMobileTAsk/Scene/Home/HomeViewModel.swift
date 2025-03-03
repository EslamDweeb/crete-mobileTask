//
//  HomeViewModel.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 02/03/2025.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModel {
    var hasErrInTxt: PublishSubject<String> = .init()
    var isLoading: BehaviorRelay<Bool> = .init(value: false)
    let searchText = BehaviorRelay<String>(value: "")
    
    private var brands = [Brand]()
    private var homerepo: HomeRepo
    
    // Use a BehaviorRelay for filteredBrands to dynamically update it
    var filteredBrands: BehaviorRelay<[Brand]> = .init(value: [])
    let disposeBag = DisposeBag()
    
    init(homerepo: HomeRepo) {
        self.homerepo = homerepo
        
        // Set up search functionality
        setupSearch()
    }
    
    private func setupSearch() {
        // Observe changes in the search text and update filteredBrands
        searchText
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance) // Add a delay for better performance
            .distinctUntilChanged() // Only emit if the text has changed
            .subscribe(onNext: { [weak self] searchText in
                guard let self = self else { return }
                let filtered = self.filterBrands(for: searchText)
                self.filteredBrands.accept(filtered)
            })
            .disposed(by: disposeBag)
    }
    
    func viewDidload() {
        Task {
            await getAllBrands()
        }
    }
    
    private func getAllBrands() async {
        isLoading.accept(true)
        do {
            let result = try await homerepo.getBrands(categoryId: 3)
            brands.append(contentsOf: result)
            
            // Update filteredBrands with the initial data
            filteredBrands.accept(brands)
        } catch {
            hasErrInTxt.onNext(error.localizedDescription)
        }
        isLoading.accept(false)
    }
    
    private func filterBrands(for searchText: String) -> [Brand] {
        if searchText.isEmpty {
            // If the search text is empty, show all brands
            return brands
        } else {
            // Filter the brands array based on the search text
            return brands.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
