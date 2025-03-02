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
        case home
       
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination{
        case .home:
            return HomeVC(coordinator)
//        case .main:
//            return MainTabBarVC(coordinator: coordinator)
       
        }
    }
}
