//
//  HomeVC.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 02/03/2025.
//

import UIKit

class HomeVC: UIViewController {
    var coordinator:Coordinator
    //MARK: - Initializers
    init(_ coordinator:Coordinator){
        self.coordinator = coordinator
        super.init(nibName: "HomeVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradientBackground(firstColor: UIColor.gradiantOrange, secondColor: UIColor.gradiantOrange.withAlphaComponent(0), thirdColor: nil, startPoint: CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint(x: 0.5, y: 1.0), location: [0.0, 1.0])
    }



}
