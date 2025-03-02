//
//  HomeVC.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 02/03/2025.
//

import UIKit

class HomeVC: BaseWireFrame<HomeViewModel> {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var findCarBtn: UIButton!
    @IBOutlet weak var searchField: SearchTextField!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var brandCollectionView: UICollectionView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        titleLbl.text = "New Cars"
        titleLbl.font = Fonts.bold(name: Fonts.FontName.Poppins.rawValue, size: FontSize.fontTwintyTwo)
        brandCollectionView.backgroundColor = .clear
        brandCollectionView.registerCell(cellClass: BrandCell.self)
        let layout = createCompositionalLayout()
        brandCollectionView.setCollectionViewLayout(layout, animated: false)
        brandCollectionView.dataSource = self
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
        print("Here In Home Screen")
    }

}
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarBrandCell.reuseIdentifier, for: indexPath) as! CarBrandCell
//        cell.configure(with: carBrands[indexPath.item])
        let cell = collectionView.dequeue(indexPath: indexPath) as BrandCell
        return cell
    }
}
