//
//  ModelCell.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import UIKit
import Kingfisher
protocol ModelCellViewModel{
    func configure(imageURL:String,modelName:String,startFrom:String,modelYear:String,isGrid:Bool)
}
class ModelCell: UICollectionViewCell,ModelCellViewModel {
    
    

    @IBOutlet weak var brandModelImageHieghtConstraint: NSLayoutConstraint!
    @IBOutlet weak var startFromLbl: UILabel!
    @IBOutlet weak var modelYearLbl: UILabel!
    @IBOutlet weak var modelNameLbl: UILabel!
    @IBOutlet weak var brandModelImage: UIImageView!
    @IBOutlet weak var containerStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(imageURL: String, modelName: String, startFrom: String, modelYear: String,isGrid:Bool) {
        brandModelImage.kf.setImage(with: URL(string: imageURL))
        modelNameLbl.text = modelName
        modelYearLbl.text = modelYear
        startFromLbl.text = startFrom + " EGP"
        if isGrid {
            containerStack.axis = .vertical
            brandModelImageHieghtConstraint.constant = 75
        }else{
            containerStack.axis = .horizontal
            brandModelImageHieghtConstraint.constant = 110
        }
    }
}

