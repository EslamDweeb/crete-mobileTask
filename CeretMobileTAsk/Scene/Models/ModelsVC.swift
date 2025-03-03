//
//  ModelsVC.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import UIKit
import Kingfisher


class ModelsVC: BaseWireFrame<ModelsViewModel> {

    @IBOutlet weak var gridOrListBtn: UIButton!
    @IBOutlet weak var brandLogoImageView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var modelsCollectionView: UICollectionView!
    @IBOutlet weak var findCarBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidload()
       
    }
    
    override func bind(viewModel: ModelsViewModel) {
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
        
        viewModel.brandImageURLSubject.subscribe {[weak self] url in
            guard let self,let url = url.element else{return}
            if url != "" {
                DispatchQueue.main.async {
                    self.brandLogoImageView.kf.setImage(with: URL(string: url))
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
