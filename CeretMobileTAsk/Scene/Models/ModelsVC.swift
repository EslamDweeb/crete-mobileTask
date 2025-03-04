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
        setupCollectionView()
        self.brandLogoImageView.kf.setImage(with: URL(string: viewModel.brandImageURL))
    }
    private func setupCollectionView(){
        modelsCollectionView.registerCell(cellClass: AdCell.self)
        modelsCollectionView.registerCell(cellClass: ModelCell.self)
        modelsCollectionView.delegate = self
        modelsCollectionView.dataSource = self
        modelsCollectionView.backgroundColor = .clear
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
        

        
        viewModel.models.subscribe { [weak self] cars in
            guard let self else{return}
            DispatchQueue.main.async {
                self.modelsCollectionView.reloadData()
            }
        }.disposed(by: disposeBag)
        viewModel.isGrid
            .subscribe(onNext: { [weak self] isGrid in
                guard let self = self else { return }
                self.updateCollectionViewLayout(isGrid: isGrid)
            })
            .disposed(by: disposeBag)
        backBtnAction()
        gridOrListBtnAction()
    }
    private func backBtnAction(){
        backBtn.rx.tap.subscribe {[weak self] tap in
            guard let self else{return}
            self.PopToOldPage()
        }.disposed(by: disposeBag)
    }
    private func gridOrListBtnAction(){
        gridOrListBtn.rx.tap.subscribe {[weak self] tap in
            guard let self else{return}
            let currentValue = self.viewModel.isGrid.value
            self.viewModel.isGrid.accept(!currentValue) // Toggle the value
            self.gridOrListBtn.setImage(currentValue == true ? UIImage(named: "List"):UIImage(named: "Grid"), for: .normal)
        }.disposed(by: disposeBag)
    }
    private func updateCollectionViewLayout(isGrid: Bool) {
        
        modelsCollectionView.collectionViewLayout.invalidateLayout()
        modelsCollectionView.reloadData()
        
    }
}
extension ModelsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 2 {
            let cell = collectionView.dequeue(indexPath: indexPath) as AdCell
            viewModel.configureAdCell(cell, item: 0)
            return cell
        }else{
            let cell = collectionView.dequeue(indexPath: indexPath) as ModelCell
            viewModel.configureCarCell(cell, item: indexPath.item)
            return cell
        }
        //return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.isGrid.value {
            return CGSize(width: (view.frame.width / 2) - 10, height: 210)
        } else {
            
            return indexPath.item != 2 ? CGSize(width: view.frame.width - 20, height: 200) :  CGSize(width: view.frame.width - 20, height: 125)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < 2 {
            coordinator.main.navigate(to: .modelGeneration(brandImageURL: viewModel.brandImageURL, model: viewModel.models.value[indexPath.item]))
        }else if indexPath.item > 2{
            coordinator.main.navigate(to: .modelGeneration(brandImageURL: viewModel.brandImageURL, model: viewModel.models.value[indexPath.item - 1]))
        }
    }
}
