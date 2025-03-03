//
//  HomeVC.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 02/03/2025.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: BaseWireFrame<HomeViewModel> {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var findCarBtn: UIButton!
    @IBOutlet weak var searchField: SearchTextField!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var brandCollectionView: UICollectionView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidload()
    }
    
    fileprivate func setupUI() {
        titleLbl.text = "New Cars"
        titleLbl.font = Fonts.bold(name: Fonts.FontName.Poppins.rawValue, size: FontSize.fontTwintyTwo)
        brandCollectionView.backgroundColor = .clear
        brandCollectionView.registerCell(cellClass: BrandCell.self)
        let layout = createCompositionalLayout()
        brandCollectionView.setCollectionViewLayout(layout, animated: false)
        //brandCollectionView.dataSource = self
    }
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
           // Define the item size
           let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(85), // 50% of the container width
            heightDimension: .fractionalHeight(1.0) // Fixed height of 50 points
           )
           let item = NSCollectionLayoutItem(layoutSize: itemSize)

           // Define the group size
           let groupSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0), // 100% of the container width
               heightDimension: .absolute(85) // Fixed height of 50 points
           )
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
           // Define the section
           let section = NSCollectionLayoutSection(group: group)
           section.interGroupSpacing = 14 // Spacing between groups (rows)
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) // Padding

           // Create the layout
           let layout = UICollectionViewCompositionalLayout(section: section)
           return layout
       }
    override func bind(viewModel: HomeViewModel) {
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
        
        searchField.rx.text.orEmpty
                    .bind(to: viewModel.searchText)
                    .disposed(by: disposeBag)
        
        viewModel.filteredBrands
                 .bind(to: brandCollectionView.rx.items(cellIdentifier: BrandCell.getIdentifier(), cellType: BrandCell.self)) { index, brand, cell in
                     //cell.configure(with: brand)
                    
                     cell.Configure(name:  brand.name, imageURL:  brand.image)
                 }
                 .disposed(by: disposeBag)

             // Handle item selection
             brandCollectionView.rx.itemSelected
                 .subscribe(onNext: { [weak self] indexPath in
                     guard let self = self else { return }
                     let selectedBrand = self.viewModel.filteredBrands.value[indexPath.item]
                     self.coordinator.main.navigate(to: .models(id: selectedBrand.id, imageURL: selectedBrand.image))
                 })
                 .disposed(by: disposeBag)
    }

}
