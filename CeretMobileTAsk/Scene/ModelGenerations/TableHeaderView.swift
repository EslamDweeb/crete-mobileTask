//
//  TableHeaderView.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import UIKit
import Kingfisher

class TableHeaderView:UIView {
    lazy var containerView:UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy var modelImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var modelNameLbl:UILabel = {
       let lbl = UILabel()
        lbl.font = Fonts.semiBold(name: Fonts.FontName.Poppins.rawValue, size: FontSize.fontMedium)
        lbl.textColor = .black
        return lbl
    }()
    
    lazy var modelYearLbl:UILabel = {
       let lbl = UILabel()
        lbl.font = Fonts.medium(name: Fonts.FontName.Poppins.rawValue, size: FontSize.fontRegular)
        lbl.textColor = UIColor.lightGray
        return lbl
    }()
    lazy var stackView:UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.addArrangedSubview(modelNameLbl)
        stackView.addArrangedSubview(modelYearLbl)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView(){
        containerView.cornerRadius = 6
        containerView.setShadow(shadowColor: UIColor.black.cgColor, shadowOffset: .init(width: 1, height: 1), shadowOpacity: 0.6, shadowRaduis: 1)
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(modelImageView)
        containerView.addSubview(stackView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        modelImageView.anchor(top: containerView.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0),size: .init(width: 230, height: 110))
        modelImageView.centerXInSuperview()
        stackView.anchor(top: modelImageView.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 20, left: 20, bottom: 8, right: 20))
    }
    func configuer(imageURL:String,modelName:String,modelYear:String){
        modelImageView.kf.setImage(with: URL(string: imageURL))
        modelNameLbl.text = modelName
        modelYearLbl.text = modelYear
    }
}
