//
//  MainNavigator.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//

import UIKit
import CoreLocation


class MainNavigator:Navigator{
    var coordinator: Coordinator
    
    enum Destination {
        case models(id:Int,imageURL:String)
        case modelGeneration(brandImageURL: String, model: Car)
       
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination{
        case .models(let id,let imageURL):
            let viewModel = ModelsViewModel(modelsRepo: DefaultModelRepo(client: ModelsClient()), brandId: id, brandImageURL: imageURL)
            return ModelsVC(viewModel: viewModel, coordinator: coordinator)
        case .modelGeneration(let brandImageURL,let model):
            let viewModel = ModelGenerationsViewModel(brandImageURL: brandImageURL, modelGenerationsRepo: DefaultModelGenerationRepo(client: ModelGenerationsClient()), model: model)
            return ModelGenerationVC(viewModel: viewModel, coordinator: coordinator)
        }
    }
}
