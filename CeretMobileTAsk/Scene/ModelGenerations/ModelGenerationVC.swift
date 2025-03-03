//
//  ModelGenerationVC.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import UIKit

class ModelGenerationVC: BaseWireFrame<ModelGenerationsViewModel> {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var brandLogoImage: UIImageView!
    @IBOutlet weak var vechilesTableView: UITableView!
    lazy var  headerview:TableHeaderView = {
       let headerView = TableHeaderView()
        return headerView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.brandLogoImage.kf.setImage(with: URL(string: viewModel.brandImageURL))
        viewModel.viewDidload()
        setupHeaderView()
      
    }
    private func setupHeaderView(){
        headerview.configuer(imageURL: viewModel.modelImageURL, modelName: viewModel.modelName, modelYear: viewModel.modelYear)
        vechilesTableView.tableHeaderView = headerview
        headerview.frame.size.height = headerview.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        //headerview.frame.size.width = view.frame.size.width - 40
    }
    override func bind(viewModel: ModelGenerationsViewModel) {
        viewModel.isLoading.subscribe {[weak self] loading in
            guard let self else{return}
            guard let isLoading = loading.element else{return}
            if isLoading{
                DispatchQueue.main.async {
                    self.showIndicator(withTitle: "", and: "")
                }
            }else{
                DispatchQueue.main.async {
                    self.hideIndicator()
                }
            }
        }.disposed(by: disposeBag)
        
        viewModel.hasErrInTxt.subscribe {[weak self] msg in
            guard let self,let msg = msg.element else{return}
            if msg != "" {
                DispatchQueue.main.async {
                    self.createAlert(title: "Error",erroMessage: msg)
                }
            }
        }.disposed(by: disposeBag)
        backBtnAction()
    }
    private func backBtnAction(){
        backBtn.rx.tap.subscribe {[weak self] tap in
            guard let self else{return}
            self.PopToOldPage()
        }.disposed(by: disposeBag)
    }
}
