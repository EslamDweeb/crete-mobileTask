//
//  AppCoordinator.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//

import UIKit
//import MOLH

class AppCoordinator:Coordinator{
    
    
    var window:UIWindow
    
    lazy var main: MainNavigator = {
        return .init(coordinator: self)
    }()
    
    
    lazy var homeScreen: UIViewController = {
        let homeVC = HomeVC(viewModel: HomeViewModel(homerepo: DefaultHomeRepo(client: HomeClient())), coordinator: self)
        let navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }()
    
    var navigationController:UINavigationController?{
       if let nav = homeScreen as? UINavigationController {
           nav.navigationBar.isHidden = true
           return nav
       }else{
           return nil
       }
       //  let navigation = UINavigationController(rootViewController: splahScreen)
            
    }
    var rootViewController:UIViewController {
        return homeScreen
    }
    
    init(window:UIWindow) {
        self.window = window
        
    }
    
    func start(){
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
