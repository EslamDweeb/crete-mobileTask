//
//  AdCell.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import UIKit
protocol AdCellViewModel{
    func configure(imageURL:String)
}
class AdCell: UICollectionViewCell,AdCellViewModel {

    @IBOutlet weak var advImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(imageURL:String){
        advImageView.kf.setImage(with: URL(string: imageURL))
    }
}
