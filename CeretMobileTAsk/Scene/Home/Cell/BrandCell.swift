//
//  BrandCell.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import UIKit
import Kingfisher
protocol BrandCellViewModel{
    func Configure(name:String,imageURL:String)
}
class BrandCell: UICollectionViewCell,BrandCellViewModel {

    @IBOutlet weak var brandNameLbl: UILabel!
    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func Configure(name:String,imageURL:String){
        brandNameLbl.text = name
        brandImageView.kf.setImage(with: URL(string: imageURL))
    }
}
