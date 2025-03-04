//
//  VehicleCell.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import UIKit

protocol VehicleCellViewModel{
    func configure(with vehicle: Vehicle)
}

class VehicleCell: UITableViewCell,VehicleCellViewModel {
    
    @IBOutlet weak var differenceLbl: UILabel!
    @IBOutlet weak var differenceImageView: UIImageView!
    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var expandStackView: UIStackView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var compareBtn: UIButton!
    @IBOutlet weak var attributesStackView: UIStackView!
    
    @IBOutlet weak var inerExpandStackView: UIStackView!
    private var attrebuitArr:[String]?
    private var isExpanded = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupView(){
        selectionStyle = .none
        differenceLbl.font = Fonts.regular(name: Fonts.FontName.Poppins.rawValue, size: FontSize.fontRegular)
        differenceLbl.textColor = UIColor.darkGray
        nameLbl.font = Fonts.regular(name: Fonts.FontName.Poppins.rawValue, size: FontSize.fontSmiLarg)
        nameLbl.textColor = .black
        priceLbl.font = Fonts.semiBold(name: Fonts.FontName.Poppins.rawValue, size: FontSize.fontSmiLarg)
        priceLbl.textColor = UIColor.gradiantOrange
        lineView.isHidden = true
        expandStackView.isHidden = true
        attributesStackView.isHidden = true
        
        compareBtn.tintColor = UIColor.vechileBtnTint
        favoriteBtn.tintColor = UIColor.vechileBtnTint
        differenceImageView.tintColor = UIColor.vechileBtnTint
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
        favoriteBtn.tintColor = UIColor.gradiantOrange
    }
    @IBAction func compareBtnAction(_ sender: Any) {
        compareBtn.tintColor = UIColor.gradiantOrange
    }
    @IBAction func expandBtnAction(_ sender: Any) {
        isExpanded.toggle()
        updateExpandState()
        if let tableView = self.superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func configure(with vehicle: Vehicle) {
        nameLbl.text = vehicle.name
        priceLbl.text = "\(vehicle.price) EGP"
        
        // Clear previous extra attributes
        attributesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if let extraAttributes = vehicle.extraAttributes, !extraAttributes.isEmpty {
            attrebuitArr = extraAttributes
            differenceLbl.text = "\(extraAttributes.count) Differences"
            lineView.isHidden = false
            expandStackView.isHidden = false
            expandBtn.isHidden = false
            inerExpandStackView.isHidden = false
        } else {
            attrebuitArr = nil
            lineView.isHidden = true
            expandStackView.isHidden = true
            attributesStackView.isHidden = true
            expandBtn.isHidden = true
            inerExpandStackView.isHidden = true
        }
    }
    
    private func updateExpandState() {
        // Update the expand button image
        let expandImage = isExpanded ? UIImage(named: "Vector") : UIImage(named: "Vector-1")
        expandBtn.setImage(expandImage, for: .normal)

        // Show/hide the attributes stack view
        attributesStackView.isHidden = !isExpanded

        // Update tint colors and text colors
        differenceImageView.tintColor = isExpanded ? .gradiantOrange : .vechileBtnTint
        differenceLbl.textColor = isExpanded ? .gradiantOrange : .darkGray

        // Add or remove attributes based on the expanded state
        if isExpanded, let attributes = attrebuitArr {
            addAttributesToStackView(attributes)
        } else {
            clearAttributes()
        }
    }

    private func addAttributesToStackView(_ attributes: [String]) {
        // Clear any existing attributes first
        clearAttributes()

        // Add each attribute as a label to the stack view
        for attribute in attributes {
            let attributeLabel = UILabel()
            attributeLabel.text = "+ " + attribute
            attributeLabel.font = Fonts.light(name: Fonts.FontName.Poppins.rawValue, size: FontSize.fontRegular)
            attributeLabel.textColor = UIColor.darkGray
            attributesStackView.addArrangedSubview(attributeLabel)
        }

        // Force layout update to ensure the stack view displays correctly
        attributesStackView.layoutIfNeeded()
       //contentView.layoutIfNeeded()
    }

    private func clearAttributes() {
        // Remove all arranged subviews from the stack view
        for subview in attributesStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
}
